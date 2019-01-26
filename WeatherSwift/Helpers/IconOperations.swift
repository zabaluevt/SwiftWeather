//
//  IconOperations.swift
//  WeatherSwift
//
//  Created by Ольга Забалуева on 20.01.2019.
//  Copyright © 2019 Тимофей Забалуев. All rights reserved.
//

import UIKit

public class IconOperations {
    
    static func getIcon(iconPath: String) -> UIImage?{
        
        if let icon = (UIImage(named: (iconPath))){
            return icon
        }
        else {
            //TODO Error

            return nil
        }
    }
}
