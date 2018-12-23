//
//  File.swift
//  WeatherSwift
//
//  Created by Ольга Забалуева on 23.12.2018.
//  Copyright © 2018 Тимофей Забалуев. All rights reserved.
//

import Foundation

struct Settings {
    
    struct API {
        //http://api.openweathermap.org/data/2.5/weather?q=city&APPID=96e1acdb11e7e23103af509121e8c25f
        static let domain = "http://api.openweathermap.org"
        
        static let secondPartPath = "/data/2.5/"
        
        enum ApiKey: String {
            case oneDay = "weather"
            case FewDays = "forecast"
        }
        static let apiKey = "weather?q=samara"
        
        static let appId = "96e1acdb11e7e23103af509121e8c25f"
        
        static var URL: String {
            return domain + secondPartPath + ApiKey.oneDay.rawValue
        }
        
        
    }
    
}
