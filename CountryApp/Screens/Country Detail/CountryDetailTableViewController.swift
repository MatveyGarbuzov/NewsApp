//
//  CountryDetailTableViewController.swift
//  CountryApp
//
//  Created by Matvey Garbuzov on 04.06.2023.
//

import UIKit

protocol VCDismissDelegate: AnyObject {
  func dissmiss()
  func loadTableView(_ data: [cellData])
}

class CountryDetailTableViewController: UIViewController {
  
  private let tableView = UITableView()
  var tableViewData: [cellData]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    
    setup()
    setupTableView()
    setupConstraints()
  }
  
  private func setup() {
    modalPresentationStyle = .pageSheet
    isModalInPresentation = true
    
    guard let sheetPresentationController else { return }
    sheetPresentationController.detents = [
      .custom(identifier: .medium, resolver: { $0.maximumDetentValue * 0.2 }),
      .custom(identifier: .large, resolver: { $0.maximumDetentValue * 0.6 })
    ]
    sheetPresentationController.prefersGrabberVisible = true
    sheetPresentationController.largestUndimmedDetentIdentifier = .large
    sheetPresentationController.preferredCornerRadius = 24.0
  }
  
  private func setupConstraints() {
    view.addSubview(tableView)
    
    tableView.snp.makeConstraints { make in
      make.top.equalToSuperview().inset(30)
      make.width.bottom.equalToSuperview()
    }
  }
  
  private func setupTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(
      MyTableViewCell.self,
      forCellReuseIdentifier: MyTableViewCell.reuseIdentifier)
    tableView.backgroundColor = .black
  }
}

extension CountryDetailTableViewController: UITableViewDelegate {}

extension CountryDetailTableViewController: UITableViewDataSource {
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

extension CountryDetailTableViewController: VCDismissDelegate {
  func dissmiss() {
    dismiss(animated: false)
  }
  
  func loadTableView(_ data: [cellData]) {
    tableViewData = data
  }
}
