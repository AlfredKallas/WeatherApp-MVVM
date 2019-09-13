//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by Kallas on 9/10/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation
import Alamofire

enum WeatherRequest: URLRequestBuilder {
    
    case weatherByRegion(longitude: Double, latitude: Double)
    
    // MARK: - Path
    internal var path: ServerPaths {
        switch self {
        case .weatherByRegion:
            return .weatherByRegion
        }
    }
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = defaultParams
        switch self {
        case .weatherByRegion(let longitude, let latitude):
            params["_ll"] = "\(longitude),\(latitude)"
            params["_auth"] = "BhxfSAF%2FUnBVeFBnUCZReAdvUmcOeAMkAX0CYVs%2BB3pTOFMyUzMDZVc5WicDLFVjAC1TMA02AzNXPAtzWigDYgZsXzMBalI1VTpQNVB%2FUXoHKVIzDi4DJAFlAmJbKAdlUzVTM1MuA2NXOlo8Ay1VYAAwUzANLQMkVzULaVoxA2gGZF85AWRSOFU6UDFQf1F6BzFSZg42AzwBMAJiWzMHZ1M5U2JTZANmVz5aPwMtVWUANlMzDTQDOlc3C2VaPwN%2FBnpfQgERUi1VelBwUDVRIwcpUmcObwNv&_c=48aaf2d5c7df4c5ffdc64ebaba1159bf"
        }
        return params
    }
    
    // MARK: - Methods
    internal var method: HTTPMethod {
        return .get
    }
}
