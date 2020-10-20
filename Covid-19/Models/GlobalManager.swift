//
//  CovidManager.swift
//  Covid-19
//
//  Created by Tarokh on 8/24/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation

protocol GlobalManagerDelegate {
    
    func didFailed(error: Error)
    func updateUI(covid: Global)
    
}

class GlobalManager {
    
    // define some variables
    var delegate: GlobalManagerDelegate?
    var covid: Global?
    
    // define some functions
    func getCovid(){
        GlobalAdapter.request(target: .all, success: { (response) in
            do {
                let covidData = try JSONDecoder().decode(Global.self, from: response.data)
                self.delegate?.updateUI(covid: covidData)
            }
            catch let jsonError as NSError {
                self.delegate?.didFailed(error: jsonError)
            }
            
        }, error: { (error) in
            self.delegate?.didFailed(error: error)
        }) { (moyaError) in
            self.delegate?.didFailed(error: moyaError)
        }
    }
    
    func getDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
    
}
