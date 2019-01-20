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
    
    func commonInit(day: String, maxTemp: String, minTemp: String, icon: UIImage){
        titleCellLabel.text = day
        minTemperature.text = minTemp
        maxTemperature.text = maxTemp
        iconImageView.image = icon
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
