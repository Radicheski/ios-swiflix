//
//  PersonTableViewCell.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 12/08/21.
//

import UIKit

class PersonTableViewCell: UITableViewCell {

    static let customIdentifier: String = "PersonTableViewCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupWith(name: String, poster: UIImage?) {
        self.nameLabel.text = name
        self.posterImage.image = poster
    }
    
}
