//
//  WeatherData+CoreDataProperties.swift
//  
//
//  Created by Kallas on 9/11/19.
//
//

import Foundation
import CoreData


extension WeatherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherData> {
        return NSFetchRequest<WeatherData>(entityName: "WeatherData")
    }

    @NSManaged public var temperature_2m: Double
    @NSManaged public var temperature_sol: Double
    @NSManaged public var temperature_500hpa: Double
    @NSManaged public var temperature_850hpa: Double
    @NSManaged public var pression: Int32
    @NSManaged public var pluie: Double
    @NSManaged public var pluieConvective: Double
    @NSManaged public var humidity: Int16
    @NSManaged public var ventMoyen: Int16
    @NSManaged public var ventRafales: Int16
    @NSManaged public var ventDirection: Int16
    @NSManaged public var isoZero: Int32
    @NSManaged public var risqueNeige: String?
    @NSManaged public var cape: Int16
    @NSManaged public var nebulositeHaute: Int16
    @NSManaged public var nebulositeMoyenne: Int16
    @NSManaged public var nebulositeBasse: Int16
    @NSManaged public var nebulositeTotale: Int16
    @NSManaged public var dateTime: String?
    
    public static func createOrUpdateFromWeatherApiData(weatherAPIData:[WeatherInDateTime], in context: NSManagedObjectContext){
        
        weatherAPIData.forEach { (singleWeatherAPIData) in
            createOrUpdateFromSingleWeatherApiData(weatherAPIData: singleWeatherAPIData, in: context)
        }
    }
    
    public static func createOrUpdateFromSingleWeatherApiData(weatherAPIData:WeatherInDateTime, in context: NSManagedObjectContext) {
        let weatherData = WeatherData.mr_findFirstOrCreate(byAttribute: "dateTime", withValue: weatherAPIData.dateTime, in: context)
        weatherData.temperature_2m = weatherAPIData.temperature.the2M
        weatherData.temperature_sol = weatherAPIData.temperature.sol
        weatherData.temperature_500hpa = weatherAPIData.temperature.the500HPa
        weatherData.temperature_850hpa = weatherAPIData.temperature.the850HPa
        
        weatherData.pression = Int32(weatherAPIData.pression.niveauDeLaMer)
        weatherData.pluie = weatherAPIData.pluie
        weatherData.pluieConvective = weatherAPIData.pluieConvective
        weatherData.humidity = Int16(weatherAPIData.humidite.the2M)
        weatherData.ventMoyen = Int16(weatherAPIData.ventMoyen.the10M)
        weatherData.ventRafales = Int16(weatherAPIData.ventRafales.the10M)
        weatherData.isoZero = Int32(weatherAPIData.isoZero)
        weatherData.risqueNeige = weatherAPIData.risqueNeige
        weatherData.cape = Int16(weatherAPIData.cape)
        weatherData.nebulositeHaute = Int16(weatherAPIData.nebulosite.haute)
        weatherData.nebulositeMoyenne = Int16(weatherAPIData.nebulosite.moyenne)
        weatherData.nebulositeHaute = Int16(weatherAPIData.nebulosite.haute)
        weatherData.nebulositeTotale = Int16(weatherAPIData.nebulosite.totale)
        
        weatherData.dateTime = weatherAPIData.dateTime
    }

}
