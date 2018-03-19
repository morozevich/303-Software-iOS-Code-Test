//
//  UserTableViewCell.swift
//  Data303
//
//  Created by carlos on 18/3/18.
//  Copyright © 2018 carlos. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    var user: User? {
        didSet {
            updateUI()
        }
    }

    func updateUI() {
        firstNameLabel.text = nil
        lastNameLabel.text = nil
        cityLabel.text = nil

        if let firtsName = user?.firtsName {
            firstNameLabel.text = firtsName
        }
        if let lastName = user?.lastName {
            lastNameLabel.text = lastName
        }
        if let city = user?.city {
            cityLabel.text = city
        }
    }
}
