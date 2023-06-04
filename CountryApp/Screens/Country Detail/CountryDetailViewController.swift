//
//  CountryDetailViewController.swift
//  CountryApp
//
//  Created by Matvey Garbuzov on 02.06.2023.
//

import UIKit
import MapKit

class CountryDetailViewController: UIViewController {
  weak var delegate: VCDismissDelegate?
  
  var viewModel: DetailCountryViewModel? {
    didSet {
      loadMap()
    }
  }
  private let mapView = MKMapView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    presentSheet()
    setupNavController()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    delegate?.dissmiss()
  }
  
  private func setupNavController() {
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.topItem?.backButtonTitle = ""
    navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    navigationItem.largeTitleDisplayMode = .never
    title = viewModel?.detailCountry?.name.common
  }
  
  private func presentSheet() {
    let nav = CountryDetailTableViewController()
    delegate = nav
    delegate?.loadTableView(viewModel?.getData() ?? [])
    
    present(nav, animated: true)
  }
  
  private func setupConstraints() {
    view.addSubview(mapView)
    
    mapView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  private func loadMap() {
    DispatchQueue.global(qos: .background).async { [self] in
      let coordinate = CLLocationCoordinate2D(latitude: viewModel?.detailCountry?.latlng[0] ?? 0, longitude: viewModel?.detailCountry?.latlng[1] ?? 0)
      DispatchQueue.main.async { [weak self] in
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        self?.mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self?.mapView.setRegion(region, animated: true)
      }
    }
  }
}
