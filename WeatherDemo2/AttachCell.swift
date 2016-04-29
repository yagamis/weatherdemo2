//
//  AttachCell.swift
//  WeatherDemo2
//
//  Created by 小波 on 16/4/29.
//  Copyright © 2016年 xiaobo. All rights reserved.
//

import UIKit

class AttachCell: UITableViewCell {
    @IBOutlet weak var labelHumid: UILabel!
    @IBOutlet weak var labelWind: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
