//
//  CompleteCell.swift
//  VocalVocab
//
//  Created by Roman Petlyak on 11/11/23.
//

import UIKit

class CompleteCell: UITableViewCell {
    
    @IBOutlet var wordLabel: UILabel!
    @IBOutlet var definitionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
