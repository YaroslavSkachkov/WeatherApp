//
//  CityCell.swift
//  WeatherApp
//
//  Created by Ярослав on 10/22/20.
//

import UIKit

class CityCell: UITableViewCell {

    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
