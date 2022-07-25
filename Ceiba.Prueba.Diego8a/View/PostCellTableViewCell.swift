//
//  PostCellTableViewCell.swift
//  Ceiba.Prueba.Diego8a
//
//  Created by Diego Ochoa on 25/07/22.
//

import UIKit

class PostCellTableViewCell: UITableViewCell {

    @IBOutlet weak var paragraphLabel: UILabel!
    @IBOutlet weak var tittleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(post: Post) {
        paragraphLabel.text = post.body
        tittleLabel.text = post.title
    }
    
}
