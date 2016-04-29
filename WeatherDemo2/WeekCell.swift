//
//  WeekCell.swift
//  WeatherDemo2
//
//  Created by 小波 on 16/4/29.
//  Copyright © 2016年 xiaobo. All rights reserved.
//

import UIKit

class WeekCell: UITableViewCell {
    @IBOutlet weak var labelWeek: UILabel!
    @IBOutlet weak var labelToday: UILabel!

    @IBOutlet weak var labelLowTemp: UILabel!
    @IBOutlet weak var labelHighTemp: UILabel!
    @IBOutlet weak var imgWeatherIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
