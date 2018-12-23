//
//  API.swift
//  WeatherSwift
//
//  Created by Ольга Забалуева on 23.12.2018.
//  Copyright © 2018 Тимофей Забалуев. All rights reserved.
//

import Alamofire
import Foundation

struct API {
    
    static func get(city: String, completHandler: @escaping ((_ film: JsonResponse) -> Void), errorHandler: @escaping ((_ error: Error) -> Void))
    {
        //Settings.API.ApiKey.oneDay.rawValue: text
        let dataRequest = request(Settings.API.URL, method: .get, parameters: ["q": city,"APPID": Settings.API.appId])
        dataRequest.responseData { (dataResponse) in
            if let error = dataResponse.error {
                print("Error!!! \(error)")
                errorHandler(error)
                return
            }
            if let data = dataResponse.data {
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(JsonResponse.self, from: data)
                    print("\(response)")
                    completHandler(response)
                } catch (let error) {
                    print("Error!!! \(error)")
                    errorHandler(error)
                }
            }
        }
    }
    
}
