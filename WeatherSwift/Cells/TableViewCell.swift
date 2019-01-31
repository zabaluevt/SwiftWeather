//
//  TableViewCell.swift
//  WeatherSwift
//
//  Created by Ольга Забалуева on 16.01.2019.
//  Copyright © 2019 Тимофей Забалуев. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var titleCellLabel: UILabel!
    
    @IBOutlet weak var minTemperature: UILabel!
    
    @IBOutlet weak var maxTemperature: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet var timeCollectionLabel: [UILabel]!

    @IBOutlet var iconCollectionImageView: [UIImageView]!
    
    @IBOutlet var degreesCollectionLabel: [UILabel]!
    
    @IBOutlet weak var bottomScrollView: UIScrollView!
    
    func commonInit(day: String, maxTemp: String, minTemp: String, icon: UIImage, additional: [Additional]){
        
        titleCellLabel.text = day
        minTemperature.text = minTemp
        maxTemperature.text = maxTemp
        iconImageView.image = icon
        
        //TODO сделать формулой через вычисления ширины экрана
        bottomScrollView.isScrollEnabled = !(additional.count < 5)
        
        for (index, element) in timeCollectionLabel.enumerated(){
            element.text = (additional.count > index) ? additional[index].additionalTimeString : ""
        }
        
        for (index, element) in iconCollectionImageView.enumerated(){
            element.image = (additional.count > index) ? additional[index].additionalIcon : nil
        }
        
        for (index, element) in degreesCollectionLabel.enumerated(){
            element.text = (additional.count > index) ? additional[index].additionalDegreesString : ""
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        bottomScrollView.isHidden = !selected
    }
}
