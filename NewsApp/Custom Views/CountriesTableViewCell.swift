//
//  CountriesTableViewCell.swift
//  NewsApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {
  static let reuseIdentifier = "CountriesTableViewCell"
  
  private let blurView: UIView = {
    let blurEffect = UIBlurEffect(style: .systemThinMaterial)
    let blurView = UIVisualEffectView(effect: blurEffect)
    
    return blurView
  }()
  
  private let countryLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    label.textAlignment = .right
    return label
  }()
  
  private let regionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 20, weight: .light)
    label.textAlignment = .left
    label.textColor = .lightGray
    return label
  }()
  
  private let nativeCountryLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
    label.textAlignment = .center
    
    return label
  }()
  
  private let flagImageView = UIImageView()
  
  private let horizontalStack: UIStackView = {
    let stack = UIStackView()
    stack.axis = .horizontal
    stack.alignment = .bottom
    stack.spacing = 5
    
    return stack
  }()
  
  private let spacer = UIView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    flagImageView.addSubview(blurView)
    horizontalStack.addArrangedSubview(countryLabel)
    horizontalStack.addArrangedSubview(regionLabel)
    horizontalStack.addArrangedSubview(spacer)
    
    contentView.addSubview(flagImageView)
    contentView.addSubview(horizontalStack)
    contentView.addSubview(nativeCountryLabel)
    
    flagImageView.snp.makeConstraints { make in
      make.left.right.equalToSuperview()
      make.bottom.top.equalToSuperview().inset(5)
      make.height.equalTo(200)
    }
    blurView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    
    nativeCountryLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview().offset(20)
    }
    
    horizontalStack.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(nativeCountryLabel.snp.top).offset(-5)
      make.width.equalToSuperview()
    }
    countryLabel.snp.makeConstraints { make in
      make.width.equalToSuperview().multipliedBy(0.5)
    }
    regionLabel.snp.makeConstraints { make in
      make.width.equalToSuperview().multipliedBy(0.3)
    }
    
//    horizontalStack.backgroundColor = .red
//    countryLabel.backgroundColor = .blue
//    regionLabel.backgroundColor = .blue
//    nativeCountryLabel.backgroundColor = .blue

    countryLabel.numberOfLines = 0
    regionLabel.numberOfLines = 0
    flagImageView.contentMode = .scaleAspectFill
    flagImageView.clipsToBounds = true
    flagImageView.layer.cornerRadius = 12
  }
  
  func configure(with article: CountriesElement) {
    countryLabel.text = article.name.common
    regionLabel.text = article.region.rawValue
    
    if let imageUrl = URL(string: article.flags.png) {
      loadImage(from: imageUrl) { image in
        if let image = image {
          DispatchQueue.main.async {
            self.flagImageView.image = image
          }
        }
      }
    }
    
    guard let lang = article.languages?.first!.key else {
      nativeCountryLabel.text = article.name.common
      return
    }
    nativeCountryLabel.text = article.name.nativeName![lang]?.common
  }
  
  private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let imageData = data, error == nil else {
        print("Error loading flag: \(error!.localizedDescription)")
        completion(nil)
        return
      }
      
      if let image = UIImage(data: imageData) {
        completion(image)
      } else {
        completion(nil)
      }
    }.resume()
  }

}
