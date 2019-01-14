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
    
    var popupViewController: SBCardPopupViewController?
    
    var allowsTapToDismissPopupCard: Bool = true
    
    var allowsSwipeToDismissPopupCard: Bool = true
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Settings.City.citiesDictionary.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        return Array(Settings.City.citiesDictionary.values)[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        Settings.City.cityForUrlName = Array(Settings.City.citiesDictionary.keys)[row]
        Settings.City.numberOfSelectedRowCity = cityPicker.selectedRow(inComponent: 0)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    static func create() -> UIViewController{
        
        return UIStoryboard.init(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "PopupViewController") as! PopupViewController
    }
    
    override func viewDidLoad() {
        
        cityPicker.delegate = self
        cityPicker.dataSource = self
        
        cityPicker.selectRow(Settings.City.numberOfSelectedRowCity, inComponent: 0, animated: true)
    }
}
