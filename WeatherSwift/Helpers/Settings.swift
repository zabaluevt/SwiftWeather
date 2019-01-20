//
//  File.swift
//  WeatherSwift
//
//  Created by Ольга Забалуева on 23.12.2018.
//  Copyright © 2018 Тимофей Забалуев. All rights reserved.
//

import Foundation

struct Settings {
    
    struct City {
        static let citiesDictionary = ["samara": "Самара", "moscow": "Москва", "london": "Лондон", "manchester": "Манчестер", "liverpool": "Ливерпуль"]
        
        static var numberOfSelectedRowCity: Int = 0
        
        static var cityForUrlName: String = "samara" {
            didSet {
                print("Выбран город " + cityForUrlName)
            }
        }
    }
    
    struct API {
        //http://api.openweathermap.org/data/2.5/weather?q=samara&APPID=96e1acdb11e7e23103af509121e8c25f
        static let domain = "http://api.openweathermap.org"
        
        static let secondPartPath = "/data/2.5/"

        static let appId = "96e1acdb11e7e23103af509121e8c25f"
        
        static var URLOneDay: String {
            return domain + secondPartPath + "weather"
        }
        static var URLFewDays: String {
            return domain + secondPartPath + "forecast"
        }
    }
}
