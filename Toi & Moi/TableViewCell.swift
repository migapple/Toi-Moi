//
//  TableViewCell.swift
//  Toi & Moi
//
//  Created by Michel Garlandat on 18/01/2017.
//  Copyright © 2017 Michel Garlandat. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var quiLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var quoiLabel: UILabel!
    @IBOutlet weak var prixLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func affiche2(post:postStuct)  {
        quiLabel.text = post.nom
        dateLabel.text = post.date
        quoiLabel.text = post.quoi
        prixLabel.text = NSString(format:"%.2f", post.prix) as String
    }
}
