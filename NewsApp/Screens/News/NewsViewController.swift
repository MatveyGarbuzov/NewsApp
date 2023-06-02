//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import Foundation
import UIKit
import Moya
import Alamofire

class NewsViewController: UIViewController {
  
  private var viewModel = FeedViewModel()
  private let tableView = UITableView()
  private let provider = MoyaProvider<NewsService>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    setupConstraints()
    loadNews()
  }
  
  private func setupViews() {
    title = "News"
    navigationController?.navigationBar.prefersLargeTitles = true
    
    view.backgroundColor = .darkGray
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseIdentifier)
  }
  
  private func setupConstraints() {
    view.addSubview(tableView)
    
    tableView.backgroundColor = .clear
    tableView.snp.makeConstraints { make in
      make.left.right.equalToSuperview()
      make.top.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
  
  private func loadNews() {
    print("LoadNews!")
    
    
    viewModel.loadFeed { [weak self] in
      self?.tableView.reloadData()
    }
  }
}

extension NewsViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let article = viewModel.articles[indexPath.row]
    print("Selected article: \(article)")
  }
}


extension NewsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.articles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseIdentifier, for: indexPath) as? NewsTableViewCell else {
      return UITableViewCell()
    }
    let article = viewModel.articles[indexPath.row]
    cell.configure(with: article)
    return cell
  }
}
