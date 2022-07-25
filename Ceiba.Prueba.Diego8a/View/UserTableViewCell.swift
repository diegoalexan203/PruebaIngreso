//
//  UserTableViewCell.swift
//  Ceiba.Prueba.Diego8a
//
//  Created by Diego Ochoa on 23/07/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    // MARK: - Outlet
    @IBOutlet weak var nameUserLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(user: User) {
        nameUserLabel.text = user.name
        phoneLabel.text = user.phone
        emailLabel.text = user.email
    }
    
}
