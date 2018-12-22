//
//  ExtendedForecastViewController.swift
//  WeatherSwift
//
//  Created by Ольга Забалуева on 23.12.2018.
//  Copyright © 2018 Тимофей Забалуев. All rights reserved.
//

import UIKit

class ExtendedForecastViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        //Добавляем свайп назад
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handelSwipe(sender:)))
        rightSwipe.direction = .right
        
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handelSwipe(sender: UISwipeGestureRecognizer){
        if let navgateBack = self.navigationController {
            navgateBack.popViewController(animated: true)
        }
    }
}
