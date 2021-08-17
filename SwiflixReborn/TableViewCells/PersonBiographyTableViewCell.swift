//
//  PersonBiographyTableViewCell.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 17/08/21.
//

import UIKit

class PersonBiographyTableViewCell: UITableViewCell {
    
    let customIdentifier = "PersonBiographyTableViewCell"

    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with text: String) {
        self.descriptionLabel.text = text
    }
    
}
