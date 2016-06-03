//
//  UserTableViewCell.swift
//  CoreDataSample
//
//  Created by Dipen Panchasara on 03/06/16.
//  Copyright © 2016 CoreData Sample. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var lblFullName:UILabel!
    @IBOutlet weak var lblEmail:UILabel!
    @IBOutlet weak var lblCountry:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
