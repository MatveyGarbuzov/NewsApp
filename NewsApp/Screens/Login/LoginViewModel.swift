//
//  LoginViewModel.swift
//  NewsApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import Foundation

class LoginViewModel {
  var login: String?
  var password: String?
  
  var isValid: Bool {
    login == "Matvey" && password == "Garbuzov"
  }
}
