//
//  WeatherAPIRequestHandler.swift
//  WeatherApp
//
//  Created by Kallas on 9/10/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation
import Alamofire

/// Response completion handler beautified.
typealias CallResponse<T> = ((ServerResponse<T>) -> Void)?
/// API protocol, The alamofire wrapper
protocol WeatherAPIRequestHandler: HandleAlamoResponse {
    /// Calling network layer via (Alamofire), this implementation can be replaced anytime in one place which is the protocol itself, applied anywhere.
    ///
    /// - Parameters:
    ///   - decoder: Codable confirmed class/struct, Model.type.
    ///   - completion: Results of the request, general errors cases handled.
    /// - Returns: Void.
    func send<T: CodableInit>(_ decoder: T.Type, completion: CallResponse<T>)
}
extension WeatherAPIRequestHandler where Self: URLRequestConvertible {
    func send<T: CodableInit>(_ decoder: T.Type, completion: CallResponse<T>) {
        request(self).validate().responseData {(response) in
            self.handleResponse(response, completion: completion)
        }
    }
}

protocol CodableInit {
    init(data: Data) throws
}



extension CodableInit where Self: Codable {
    
    init(data: Data) throws {
        let decoder = JSONDecoder()
        // I'm using snake case strategy, also Codable.
        // again you can use your own decoding lib/strategy
        self = try decoder.decode(Self.self, from: data)
    }
}

enum ServerResponse<T> {
    case success(T), failure(LocalizedError?)
}

protocol HandleAlamoResponse {
    /// Handles request response, never called anywhere but APIRequestHandler
    ///
    /// - Parameters:
    ///   - response: response from network request, for now alamofire Data response
    ///   - completion: completing processing the json response, and delivering it in the completion handler
    func handleResponse<T: CodableInit>(_ response: DataResponse<Data>, completion: CallResponse<T>)
}

extension HandleAlamoResponse {
    
    func handleResponse<T: CodableInit>(_ response: DataResponse<Data>, completion: CallResponse<T>) {
        switch response.result {
        case .failure(let error):
            completion?(ServerResponse<T>.failure(error as? LocalizedError))
        case .success(let value):
            do {
                let modules = try T(data: value)
                completion?(ServerResponse<T>.success(modules))
            }catch {
                completion?(ServerResponse<T>.failure(error as? LocalizedError))
            }
        }
    }
    
}
