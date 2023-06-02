//
//  CountriesViewController.swift
//  NewsApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import Foundation
import UIKit
import Moya
import Alamofire

class CountriesViewController: UIViewController {
  
  private var viewModel = CountriesViewModel()
  private let tableView = UITableView()
  private let provider = MoyaProvider<CountriesService>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    setupConstraints()
    loadCountries()
  }
  
  private func setupViews() {
    title = "Countries"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    view.backgroundColor = .darkGray
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(CountriesTableViewCell.self, forCellReuseIdentifier: CountriesTableViewCell.reuseIdentifier)
  }
  
  private func setupConstraints() {
    view.addSubview(tableView)
    
    tableView.backgroundColor = .clear
    tableView.snp.makeConstraints { make in
      make.left.right.bottom.equalToSuperview()
      make.top.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func loadCountries() {
    print("Loading Countries!")
    
    provider.request(.getCountries) { result in
      switch result {
      case .success(let response):
        let article = try! JSONDecoder().decode(Countries.self, from: response.data)
        self.viewModel.countries = article
    
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print("Countries LOADED!")
        
      case .failure(let error):
        print("FAILURE: \(error)")
      }
    }
  }
}

extension CountriesViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let country = viewModel.countries[indexPath.row]
    print("Selected country: \(country)")
  }
}

extension CountriesViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.countries.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: CountriesTableViewCell.reuseIdentifier, for: indexPath) as? CountriesTableViewCell else {
      return UITableViewCell()
    }
    let country = viewModel.countries[indexPath.row]
    print("Configuring: \(country.name.common)")
    cell.configure(with: country)
    return cell
  }
}
