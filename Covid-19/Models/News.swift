//
//  News.swift
//  Covid-19
//
//  Created by Tarokh on 8/24/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation

struct News: Codable {
    var status: String?
    var totalResults: Int?
    var articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    var source: Source?
    var title: String
    var url: String?
    var urlToImage: String?

    enum CodingKeys: String, CodingKey {
        case source, title
        case url, urlToImage
    }
}

// MARK: - Source
struct Source: Codable {
    var id: String?
    var name: String?
}
