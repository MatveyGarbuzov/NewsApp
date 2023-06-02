//
//  NewsModel.swift
//  NewsApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import UIKit

struct Article: Decodable {
    let title: String
    let description: String
    let date: String
    let image: String
}

