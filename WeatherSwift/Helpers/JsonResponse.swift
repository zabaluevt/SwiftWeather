//
//  JsonResponse.swift
//  WeatherSwift
//
//  Created by Ольга Забалуева on 23.12.2018.
//  Copyright © 2018 Тимофей Забалуев. All rights reserved.
//

import Foundation

struct JsonResponse: Codable {
    let message: Double?
    let cnt: Int?
    let list: [List]?
    let city: City?
    let coord: Coord?
    let weather: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let dt: Int?
    let id: Int?
    let name: String?
}

struct Main: Codable {
    let temp: Double?
    let pressure, humidity: Int?
    let tempMin, tempMax: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp, pressure, humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct Coord: Codable {
    let lon, lat: Double?
}

struct Weather: Codable {
    let main, description, icon: String?
}

struct City: Codable {
    let name: String?
    let coord: Coord?
    let country: String?
    let population: Int?
}

struct List: Codable {
    let dt: Int?
    let main: MainClass?
    let weather: [Weather]?
    let wind: Wind?
    let dtTxt: String?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, wind
        case dtTxt = "dt_txt"
    }
}

struct MainClass: Codable {
    let temp, tempMin, tempMax, pressure: Double?
    let seaLevel, grndLevel: Double?
    let humidity: Int?
    let tempKf: Double?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

enum Description: String, Codable {
    case brokenClouds = "broken clouds"
    case clearSky = "clear sky"
    case lightRain = "light rain"
    case lightSnow = "light snow"
    case snow = "snow"
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
}

struct Wind: Codable {
    let speed, deg: Double?
}
