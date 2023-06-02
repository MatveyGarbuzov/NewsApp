//
//  CountriesTableViewCell.swift
//  NewsApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {
  static let reuseIdentifier = "CountriesTableViewCell"
  
  private let titleLabel = UILabel()
  private let descriptionLabel = UILabel()
  private let dateLabel = UILabel()
  private let flagImageView = UIImageView()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
//    backgroundColor = .gray
    contentView.backgroundColor = .red
    contentView.layer.cornerRadius = 12
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(descriptionLabel)
    contentView.addSubview(dateLabel)
    contentView.addSubview(flagImageView)
    
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
    flagImageView.snp.makeConstraints { make in
      make.leading.equalTo(titleLabel)
      make.trailing.equalTo(titleLabel)
      make.height.equalTo(200)
      make.top.equalTo(dateLabel.snp.bottom).offset(8)
      make.bottom.equalToSuperview().inset(16)
    }
    titleLabel.numberOfLines = 0
    descriptionLabel.numberOfLines = 0
    dateLabel.textColor = .red
    flagImageView.contentMode = .scaleAspectFill
    flagImageView.clipsToBounds = true
  }
  
  
  func configure(with article: CountriesElement) {
    titleLabel.text = article.name.common
    
    descriptionLabel.text = article.region.rawValue
    
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
      dateLabel.text = article.name.common
      return
    }
    dateLabel.text = article.name.nativeName![lang]?.common
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


/*
 
 func configure(with article: CountriesElement) {
   titleLabel.text = article.name.common
   
   descriptionLabel.text = article.region.rawValue
   
   let imageUrl = URL(string: article.flags.png)!
   // Инициализация задачи
   let task = URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
       // Проверяем наличие ошибок
       guard let imageData = data, error == nil else {
           print("Ошибка загрузки изображения: \(error!.localizedDescription)")
           return
       }
       
       // Декодирование изображения
       if let image = UIImage(data: imageData) {
           DispatchQueue.main.async {
               // Показываем изображение в интерфейсе
             self.flagImageView.image = image
           }
       }
   }

   // Запуск задачи
   task.resume()
   
   
   guard let lang = article.languages?.first!.key else {
     dateLabel.text = article.name.common
     return
   }
   dateLabel.text = article.name.nativeName![lang]?.common
 }
 
 */
