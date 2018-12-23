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

    override func viewDidLoad() {
        super.viewDidLoad()
    
        API.get(city: "samara", completHandler: { response in
            let tt = response.list?.first?.dtTxt
           
        }, errorHandler: { error in
            
        })
    }
}

