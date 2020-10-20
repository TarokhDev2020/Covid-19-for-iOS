//
//  NewsManager.swift
//  Covid-19
//
//  Created by Tarokh on 8/24/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation
import Moya

protocol NewsManagerDelegate {
    func didFailed(error: Error)
    func updateUI(news: [Article])
}

class NewsManager {
    
    // define some variables
    var delegate: NewsManagerDelegate?
    var newsItems = [Article]()
    
    // define some functions
    func getNews() {
        GlobalAdapter.request(target: .news, success: { (response) in
            do {
                let news = try JSONDecoder().decode(News.self, from: response.data)
                for articleItems in news.articles! {
                    self.newsItems.append(articleItems)
                    self.delegate?.updateUI(news: self.newsItems)
                }
            }
            catch let jsonError as NSError {
                self.delegate?.didFailed(error: jsonError)
            }
            
        }, error: { (err) in
            self.delegate?.didFailed(error: err)
        }) { (moyaError) in
            self.delegate?.didFailed(error: moyaError)
        }
    }
    
}
