//
//  CountryDetailViewController.swift
//  CountryApp
//
//  Created by Matvey Garbuzov on 02.06.2023.
//

import UIKit
import MapKit

class CountryDetailViewController: UIViewController {
  
  var viewModel: DetailCountryViewModel? {
    didSet {
      updateUI()
    }
  }
  private let mapView = MKMapView()
  private let tableView = UITableView()
  private var tableViewData: [cellData]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    view.backgroundColor = .black
    setupViews()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.topItem?.backButtonTitle = ""
    navigationItem.largeTitleDisplayMode = .never
    title = viewModel?.detailCountry?.name.common
  }
  
  private func setupViews() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.reuseIdentifier)
    
    let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    mapView.addGestureRecognizer(recognizer)
    
    viewModel?.mapHeightChanged = { [weak self] mapHeight in
      self?.mapView.snp.updateConstraints { make in
        make.height.equalTo(mapHeight)
      }
      
      UIView.animate(withDuration: 0.3) {
        self?.view.layoutIfNeeded()
      }
    }
  }
  
  private func setupConstraints() {
    view.addSubview(mapView)
    view.addSubview(tableView)

    mapView.snp.makeConstraints { make in
      make.top.equalTo(view)
      make.width.equalToSuperview()
      make.height.equalTo(viewModel?.initialMapHeight ?? 250)
    }
    
    tableView.snp.makeConstraints { make in
      make.top.equalTo(mapView.snp.bottom)
      make.bottom.width.equalToSuperview()

    }
    tableView.backgroundColor = .purple
  }
  
  private func updateUI() {
    loadCellData()
    loadMap()
  }
  
  private func loadCellData() {
    tableViewData = viewModel?.getData()
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
  
  @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
    viewModel?.toggleMapHeight()
  }
  

}


extension CountryDetailViewController: UITableViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y < 5   {
      if viewModel?.isMapExpanded == false {
        viewModel?.toggleMapHeight()
      }
    }
  }
}

extension CountryDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.reuseIdentifier, for: indexPath) as! MyTableViewCell
    
    if indexPath.row == 0 {
      cell.titleLabel.text = tableViewData?[indexPath.section].sectionTitle
    } else {
      cell.titleLabel.text = tableViewData?[indexPath.section].sectionData[indexPath.row - 1]
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if indexPath.row == 0 {
      self.tableViewData?[indexPath.section].opened.toggle()
      let sections = IndexSet.init(integer: indexPath.section)
      tableView.reloadSections(sections, with: .none)
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
      return 50 // Set height for sections
    } else {
      return 30 // Set height for rows
    }
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return tableViewData?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tableViewData?[section].opened == true {
      return (tableViewData?[section].sectionData.count)! + 1
    }
    return 1
  }
}
