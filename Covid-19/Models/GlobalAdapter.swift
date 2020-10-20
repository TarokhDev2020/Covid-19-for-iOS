//
//  CovidAdapter.swift
//  Covid-19
//
//  Created by Tarokh on 8/24/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import Foundation
import Moya

struct GlobalAdapter {
    
    // define some variables
    static let provider = MoyaProvider<GlobalApi>()
    
    // define some functions
    static func request(target: GlobalApi, success successCallback: @escaping (Response) -> Void, error errorCallback: @escaping (Swift.Error) -> Void, failure failureCallback: @escaping (MoyaError) -> Void) {
        provider.request(target) { (result) in
            switch result {
            case .success(let response):
                if response.statusCode >= 200 {
                    successCallback(response)
                }
                else {
                    let error = NSError(domain: "", code: -1, userInfo: nil)
                    errorCallback(error)
                }
                
            case .failure(let error):
                failureCallback(error)
            }
        }
    }
    
}
