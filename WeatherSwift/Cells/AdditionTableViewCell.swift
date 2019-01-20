//
//  AdditionTableViewCell.swift
//  WeatherSwift
//
//  Created by Ольга Забалуева on 16.01.2019.
//  Copyright © 2019 Тимофей Забалуев. All rights reserved.
//

import UIKit

class AdditionTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func commonInit(time: String, degrees: String, icon: UIImage){
        timeLabel.text = time
//        degreesLabel.text = degrees
//        IconImageView.image = icon
    }
}
