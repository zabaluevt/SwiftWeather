//
//  DateOperations.swift
//  WeatherSwift
//
//  Created by Ольга Забалуева on 19.01.2019.
//  Copyright © 2019 Тимофей Забалуев. All rights reserved.
//

import Foundation

public class DateOperations{

    static func getDayOfWeek(index: Int) -> String{
        
        var tempIndex = index
        if index > 7 {
            tempIndex =  index - 7
        }
        
        switch tempIndex {
            case 1:
                return "Воскресение"
            case 2:
                return "Понедельник"
            case 3:
                return "Вторник"
            case 4:
                return "Среда"
            case 5:
                return "Четверг"
            case 6:
                return "Пятница"
            case 7:
                return "Суббота"
            
            default:
                return ""
        }
    }
}
