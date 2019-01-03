//
//  ViewController.swift
//  WeatherSwift
//
//  Created by Ольга Забалуева on 22.12.2018.
//  Copyright © 2018 Тимофей Забалуев. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {

    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    func getIcon(iconPath: String) -> UIImage?{
        if (UIImage(named: iconPath) != nil){
            return UIImage(named: iconPath)!
        }
        else {
            //TODO Error
            
            return nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        API.get(city: "samara", completHandler: { response in
            //let tt = response.list?.first?.dtTxt
            
            self.iconImageView.image = self.getIcon(iconPath: response.weather?.first?.icon ?? "")
            self.temperature.text = String(format:"%.1f", (response.main?.temp)! - 273)
        }, errorHandler: { error in
            
        })
    }
}

