//
//  CovidApi.swift
//  Covid-19
//
//  Created by Tarokh on 8/24/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation
import Moya
import Alamofire

enum GlobalApi {
    case all
    case news
    case country
}

extension GlobalApi: TargetType {
    
    var baseURL: URL {
        switch self {
        case .all:
            return URL(string: "https://disease.sh/v3/covid-19")!
        case .news:
            return URL(string: "https://newsapi.org/v2")!
        case .country:
            return URL(string: "https://disease.sh/v3/covid-19")!
        }
    }
    
    var path: String {
        switch self {
        case .all:
            return "/all"
        case .news:
            return "/top-headlines"
        case .country:
            return "/countries"
        }
    }
    
    
    var sampleData: Data {
        switch self {
        case .all:
            return Data()
        case .news:
            return Data()
        case .country:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .all:
            return .requestPlain
        case .news:
            return .requestParameters(parameters: ["country": "us", "category": "health"], encoding: URLEncoding.queryString)
        case .country:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .all:
            return ["Content-Type": "application/json"]
        case .news:
            return ["Content-Type": "application/json", "x-api-key":"efd0b4278f4944e9a1781ed64d35f56e"]
        case .country:
            return ["Content-Type": "application/json"]
        }
    }

    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
    
    var method: Moya.Method {
        switch self {
        case .all:
            return  .get
        case .news:
            return .get
        case .country:
            return .get
        }
    }
    
    var parametersEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    
}
