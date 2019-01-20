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

    var refreshControl = UIRefreshControl()
    
    @IBAction func menuButtonClick(_ sender: Any) {
        
        let popup = PopupViewController.create()
        let sbPopup = SBCardPopupViewController(contentViewController: popup)
        
        sbPopup.show(onViewController: self)
        
    }
    
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
    func makeRequest() {
        API.get(city: Settings.City.cityForUrlName, url: Settings.API.URLOneDay, completHandler: { response in
            //let tt = response.list?.first?.dtTxt
            
            self.iconImageView.image = self.getIcon(iconPath: response?.weather?.first?.icon ?? "")
            self.temperature.text = String(format:"%.1f", (response?.main?.temp)! - 273)
        }, errorHandler: { error in
            print("error")
        })
    }
    
    @objc func refresh(){
        
        self.viewDidLoad()
        //reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //swipe down
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        //view.addSubview(refreshControl)
        
        
        makeRequest()
        
        
       
        //let circleLayer = CAShapeLayer();
//        circleLayer.path = UIBezierPath(ovalIn: CGRect(x: 50, y: 50, width: 100, height: 100)).cgPath;
         //navigationController?.toolbarItems?
//        view.layer.addSublayer(circleLayer)
    }
}

