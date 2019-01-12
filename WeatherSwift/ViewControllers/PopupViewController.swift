//
//  PopupViewController.swift
//  WeatherSwift
//
//  Created by Ольга Забалуева on 10.01.2019.
//  Copyright © 2019 Тимофей Забалуев. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController, SBCardPopupContent, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var cityPicker: UIPickerView!
    let arrayCities = ["Самара", "Москва", "Лондон", "Манчестер", "Ливерпуль"]
    
    var popupViewController: SBCardPopupViewController?
    
    var allowsTapToDismissPopupCard: Bool = true
    
    var allowsSwipeToDismissPopupCard: Bool = true
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayCities.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayCities[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch arrayCities[row] {
            case "Самара":
                Settings.API.city = "Samara"
            case "Москва":
                Settings.API.city = "Moscow"
            case "Лондон":
                Settings.API.city = "London"
            case "Манчестер":
                Settings.API.city = "Manchester"
            case "Ливерпуль":
                Settings.API.city = "Liverpool"
            default:
                Settings.API.city = "Empty"
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    static func create() -> UIViewController{
        let storyboard = UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
        
        return storyboard
    }
    
    override func viewDidLoad() {
        cityPicker.delegate = self
        cityPicker.dataSource = self
    }
}
