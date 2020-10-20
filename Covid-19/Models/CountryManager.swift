//
//  CountriesManager.swift
//  Covid-19
//
//  Created by Tarokh on 8/25/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation

protocol CountryManagerDelegate {
    func didFailed(error: Error)
    func updateUI(countries: [Country])
}

class CountryManager {
    
    // define some variables
    var countryItems = [Country]()
    var delegate: CountryManagerDelegate?
    
    // define some functions
    func getCountries() {
        GlobalAdapter.request(target: .country, success: { (response) in
            do {
                let countryResponse = try JSONDecoder().decode([Country].self, from: response.data)
                for countries in countryResponse {
                    self.countryItems.append(countries)
                    self.delegate?.updateUI(countries: self.countryItems)
                }
            }
            catch let jsonError as NSError {
                self.delegate?.didFailed(error: jsonError)
            }
        }, error: { (err) in
            self.delegate?.didFailed(error: err)
        }) { (moyaErr) in
            self.delegate?.didFailed(error: moyaErr)
        }
    }
    
}
