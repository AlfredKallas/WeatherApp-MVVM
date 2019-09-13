//
//  WeatherAPIModel.swift
//  WeatherApp
//
//  Created by Kallas on 9/10/19.
//  Copyright © 2019 AK. All rights reserved.
//

import Foundation

// MARK: - Humidite
struct Humidite: Codable {
    let the2M: Double
    
    enum CodingKeys: String, CodingKey {
        case the2M = "2m"
    }
}

// MARK: - Nebulosite
struct Nebulosite: Codable {
    let haute, moyenne, basse, totale: Int
}

// MARK: - Pression
struct Pression: Codable {
    let niveauDeLaMer: Int
    
    enum CodingKeys: String, CodingKey {
        case niveauDeLaMer = "niveau_de_la_mer"
    }
}

// MARK: - Temperature
struct Temperature: Codable {
    let the2M, sol, the500HPa, the850HPa: Double
    
    enum CodingKeys: String, CodingKey {
        case the2M = "2m"
        case sol
        case the500HPa = "500hPa"
        case the850HPa = "850hPa"
    }
}

// MARK: - Vent
struct Vent: Codable {
    let the10M: Double
    
    enum CodingKeys: String, CodingKey {
        case the10M = "10m"
    }
}

// MARK: - WeatherInDateTime
public struct WeatherInDateTime: Codable {
    let temperature: Temperature
    let pression: Pression
    let pluie, pluieConvective: Double
    let humidite: Humidite
    let ventMoyen, ventRafales, ventDirection: Vent
    let isoZero: Int
    let risqueNeige: String
    let cape: Int
    let nebulosite: Nebulosite
    var dateTime:String!
    
    enum CodingKeys: String, CodingKey {
        case temperature, pression, pluie
        case pluieConvective = "pluie_convective"
        case humidite
        case ventMoyen = "vent_moyen"
        case ventRafales = "vent_rafales"
        case ventDirection = "vent_direction"
        case isoZero = "iso_zero"
        case risqueNeige = "risque_neige"
        case cape, nebulosite
        case dateTime
    }
}

/// When encoding/decoding, this struct allows you to dynamically read/create any coding key without knowing the values ahead of time.
struct DynamicCodingKey: CodingKey {
    var stringValue: String
    init?(stringValue: String) { self.stringValue = stringValue }
    
    var intValue: Int? { return nil }
    init?(intValue: Int) { return nil }
}

private enum WeatherAPIResponseCodingKeys: String, CodingKey {
    case requestState = "request_state"
    case requestKey = "request_key"
    case message
    case modelRun = "model_run"
    case source
}

struct WeattherAPIResponse: CodableInit,Codable {
    
    let weatherInDateTimeList: [WeatherInDateTime]
    let requestState: Int?
    let requestKey, message, modelRun, source: String?
    
    init(from decoder: Decoder) throws {
        // Key the JSON container with our dynamic keys.
        let container = try decoder.container(keyedBy: WeatherAPIResponseCodingKeys.self)
        requestState = try container.decode(Int.self, forKey: .requestState)
        requestKey = try container.decode(String.self, forKey: .requestKey)
        message = try container.decode(String.self, forKey: .message)
        modelRun = try container.decode(String.self, forKey: .modelRun)
        source = try container.decode(String.self, forKey: .source)
        let weatherDateTimeContainer = try decoder.container(keyedBy: DynamicCodingKey.self)
        //
        //        // The container's keys will be the names of each of the WeatherDateTimes.
        //        // We can loop over each key and decode the Content from the JSON for that
        //        // key, then use the key as the name to create our WeatherDateTime.
        weatherInDateTimeList = weatherDateTimeContainer.allKeys.map { key in
            do {
                var weatherInDateTime = try weatherDateTimeContainer.decode(WeatherInDateTime.self, forKey: key)
                weatherInDateTime.dateTime = key.stringValue
                return weatherInDateTime
            }catch {
                return nil
            }
            }.compactMap{ $0 }
    }
    
}
