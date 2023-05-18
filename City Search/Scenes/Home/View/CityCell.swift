//
//  CityCell.swift
//  City Search
//
//  Created by Kaung Htet Win on 12/5/23.
//

import UIKit

class CityCell: UITableViewCell {
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func config(data: HomeModel) {
        cityNameLabel.text = "\(data.city ?? ""), \(data.country ?? "")"
        locationLabel.text = "\(data.location?.lat ?? 0.0)| \(data.location?.lon ?? 0.0)"
    }
}
