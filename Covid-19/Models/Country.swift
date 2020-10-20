//
//  Countries.swift
//  Covid-19
//
//  Created by Tarokh on 8/25/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation

struct Country: Codable {
    var country: String?
    var cases, deaths: Int?
    var recovered, active: Int?
    var countryInfo: CountryInfo?
}


// MARK: - CountryInfo
struct CountryInfo: Codable {
    var _id: Int?
    var iso2, iso3: String?
    var lat, long: Double?
    var flag: String?

    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case iso2, iso3, lat, long, flag
    }
}
