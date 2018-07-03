//
//  HotelsCell.swift
//  HelnanProject
//
//  Created by Mahmoud on 6/1/18.
//  Copyright © 2018 CyanDH. All rights reserved.
//

import UIKit

class HotelsCell: UITableViewCell {

    @IBOutlet var imageHotel: UIImageView!
    @IBOutlet var hotelName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
