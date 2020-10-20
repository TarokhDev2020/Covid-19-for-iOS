//
//  CountryCell.swift
//  Covid-19
//
//  Created by Tarokh on 8/25/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    
    //MARK: - @IBOutlets
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var countryImageView: UIImageView!
    @IBOutlet var caseLabel: UILabel!
    @IBOutlet var deathLabel: UILabel!
    @IBOutlet var recoveredLabel: UILabel!
    @IBOutlet var activeLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
