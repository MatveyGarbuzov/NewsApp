//
//  ErrorLabel.swift
//  NewsApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import UIKit

class ErrorLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    alpha = 0
    text = "Try another login or password"
    layer.cornerRadius = 12
    layer.masksToBounds = true
    textAlignment = .center
    backgroundColor = .red
    font = UIFont.systemFont(ofSize: 16, weight: .bold)
  }
  
  func show() {
    self.shake()
    UIView.animate(withDuration: 0.3) {
      self.alpha = 1
    }
  }
  
  func hide() {
    UIView.animate(withDuration: 0.3) {
      self.alpha = 0
    }
  }
}
