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
    
    func makeRequest() {
        guard CheckInternet.connection() else {
            let alert = UIAlertController(title: "Ошибка", message: "Проверьте соединение с интернетом.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Хорошо", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        API.get(city: Settings.City.cityForUrlName, url: Settings.API.URLOneDay, completHandler: { response in
            self.cityNameLabel.text = Settings.City.cityForDisplayName
            self.descriptionWeatherLabel.text = response?.weather?.first?.description ?? ""
            self.iconImageView.image = IconOperations.getIcon(iconPath: response?.weather?.first?.icon ?? "")
            self.temperature.text = String(format:"%.0f", (response?.main?.temp)! - 273) + "℃"
        }, errorHandler: { error in
            
            let alert = UIAlertController(title: "Ошибка", message: "Произошла ошибка получения данных с сервера, попробуйте позже.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Хорошо", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func popupClosed() {
        makeRequest()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.jpg")!)
        makeRequest()
    }
}

