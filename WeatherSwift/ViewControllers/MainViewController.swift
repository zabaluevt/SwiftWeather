//
//  ViewController.swift
//  WeatherSwift
//
//  Created by Ольга Забалуева on 22.12.2018.
//  Copyright © 2018 Тимофей Забалуев. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController, PopupDelegate {
    
    func popupClosed() {
        makeRequest()
    }
    
    @IBAction func menuButtonClick(_ sender: Any) {
        
        let popup = PopupViewController.create()
        let sbPopup = SBCardPopupViewController(contentViewController: popup)
        
        sbPopup.show(onViewController: self)
        PopupViewController.shared.delegate = self
    }
    
    
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descriptionWeatherLabel: UILabel!
    
    func getIcon(iconPath: String) -> UIImage?{
        
        if (UIImage(named: iconPath) != nil){
            return UIImage(named: iconPath)!
        }
        else {
            //TODO Error

            return nil
        }
    }
    
    func makeRequest() {
        
        API.get(city: Settings.City.cityForUrlName, url: Settings.API.URLOneDay, completHandler: { response in
            self.cityNameLabel.text = Settings.City.cityForDisplayName
            self.descriptionWeatherLabel.text = response?.weather?.first?.description ?? ""
            self.iconImageView.image = self.getIcon(iconPath: response?.weather?.first?.icon ?? "")
            self.temperature.text = String(format:"%.0f", (response?.main?.temp)! - 273) + "℃"
        }, errorHandler: { error in
            print("error")
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        makeRequest()
    }
}

