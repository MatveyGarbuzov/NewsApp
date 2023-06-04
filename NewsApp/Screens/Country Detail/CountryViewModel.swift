//
//  CountryViewModel.swift
//  NewsApp
//
//  Created by Matvey Garbuzov on 02.06.2023.
//

import Foundation

class DetailCountryViewModel {
  var currentMapHeight: CGFloat {
    isMapExpanded ? enlargedMapHeight : initialMapHeight
  }
  
  var mapHeightChanged: ((CGFloat) -> ())?
  var isMapExpanded = false
  
  var initialMapHeight: CGFloat = 300
  var enlargedMapHeight: CGFloat = 600
  
  func toggleMapHeight() {
    isMapExpanded.toggle()
    mapHeightChanged?(currentMapHeight)
  }
  
  
  var detailCountry: CountriesElement?
  
  func getData() -> [cellData] {
    let commonName = "Common name: \(detailCountry?.name.common ?? "")"
    
    let lang = detailCountry?.languages?.first!.key
    var nativeName = "Native name: "
    nativeName += lang == nil ? detailCountry?.name.common ?? "" : detailCountry?.name.nativeName![lang!]?.common ?? ""
    
    let mainInfoSection:cellData = cellData(opened: false, sectionTitle: "Main information", sectionData: [commonName, nativeName])
    return [mainInfoSection]
  }
}
