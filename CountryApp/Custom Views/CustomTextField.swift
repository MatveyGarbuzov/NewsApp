//
//  CustomTextField.swift
//  CountryApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import UIKit

class CustomTextField: UITextField {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    borderStyle = .roundedRect
    font = UIFont.systemFont(ofSize: 16)
    autocorrectionType = .no
    clearButtonMode = .whileEditing
    returnKeyType = .done
  }
}
