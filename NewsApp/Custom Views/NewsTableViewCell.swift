//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
  static let reuseIdentifier = "NewsTableViewCell"
  
  private let titleLabel = UILabel()
  private let descriptionLabel = UILabel()
  private let dateLabel = UILabel()
  private let newsImageView = UIImageView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    backgroundColor = .systemPink
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(dateLabel)
    contentView.addSubview(newsImageView)
    titleLabel.snp.makeConstraints { make in
      make.leading.equalToSuperview().offset(16)
      make.trailing.equalToSuperview().inset(16)
      make.top.equalToSuperview().offset(16)
    }
    descriptionLabel.snp.makeConstraints { make in
      make.leading.equalTo(titleLabel)
      make.trailing.equalTo(titleLabel)
      make.top.equalTo(titleLabel.snp.bottom).offset(8)
    }
    dateLabel.snp.makeConstraints { make in
      make.leading.equalTo(titleLabel)
      make.trailing.equalTo(titleLabel)
      make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
    }
    newsImageView.snp.makeConstraints { make in
      make.leading.equalTo(titleLabel)
      make.trailing.equalTo(titleLabel)
      make.height.equalTo(200)
      make.top.equalTo(dateLabel.snp.bottom).offset(8)
      make.bottom.equalToSuperview().inset(16)
    }
    titleLabel.numberOfLines = 0
    descriptionLabel.numberOfLines = 0
    dateLabel.textColor = .gray
    newsImageView.contentMode = .scaleAspectFill
    newsImageView.clipsToBounds = true
  }
  
  
  func configure(with article: Article) {
    titleLabel.text = article.title
    descriptionLabel.text = article.description
    dateLabel.text = article.date
//    newsImageView.image = article.image
  }
}
