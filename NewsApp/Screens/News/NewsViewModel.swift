//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Matvey Garbuzov on 01.06.2023.
//

import UIKit

class FeedViewModel {
  var articles: [Article] = []
  
  func loadFeed(completion: @escaping () -> Void) {
    let article1 = Article(title: "Article 1", description: "This is a long description of article 1", date: "Jan 1, 2022", image: "article1")
    let article2 = Article(title: "Article 2", description: "This is a long description of article 2", date: "Jan 2, 2022", image: "article2")
    let article3 = Article(title: "Article 3", description: "This is a long description of article 3", date: "Jan 3, 2022", image: "article3")
    let article4 = Article(title: "Article 4", description: "This is a long description of article 4", date: "Jan 1, 2022", image: "article1")
    let article5 = Article(title: "Article 5", description: "This is a long description of article 5", date: "Jan 2, 2022", image: "article2")
    let article6 = Article(title: "Article 6", description: "This is a long description of article 6", date: "Jan 3, 2022", image: "article3")
    
    articles = [article1, article2, article3, article4, article5, article6]
    completion()
  }
}
