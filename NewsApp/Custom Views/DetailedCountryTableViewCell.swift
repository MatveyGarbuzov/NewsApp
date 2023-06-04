//
//  DetailedCountryTableViewCell.swift
//  NewsApp
//
//  Created by Matvey Garbuzov on 03.06.2023.
//

import UIKit

class MyTableViewCell: UITableViewCell {
  static let reuseIdentifier = "MyTableViewCell"
  
  let titleLabel: UILabel = {
    let titleLabel = UILabel()
    titleLabel.numberOfLines = 0
    
    return titleLabel
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.selectionStyle = .none
    contentView.addSubview(titleLabel)
    
    titleLabel.snp.makeConstraints { make in
      make.top.equalTo(contentView.snp.top).offset(8)
      make.leading.equalTo(contentView.snp.leading).offset(16)
      make.trailing.equalTo(contentView.snp.trailing).offset(-16)
      make.bottom.equalTo(contentView.snp.bottom).offset(-8)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
