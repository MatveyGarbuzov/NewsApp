//
//  API.swift
//  CountryApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import Foundation
import Moya

//типы запросов
enum CountriesService {
  case getCountries
}

extension CountriesService: TargetType {
  var baseURL: URL {
    URL(string: "https://restcountries.com")!
  }
  
  var path: String {
    switch self {
    case .getCountries:
      return "v3.1/all"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getCountries:
      return .get
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .getCountries:
      return .requestParameters(parameters: ["apikey": ""], encoding: URLEncoding.queryString)
    }
  }
  
  var headers: [String : String]? {
    return ["Content-Type" : "application/json"]
  }
}
