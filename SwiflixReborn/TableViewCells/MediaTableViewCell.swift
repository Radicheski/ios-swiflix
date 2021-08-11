//
//  MediaTableViewCell.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 11/08/21.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    
    static let customIdentifier: String = "MediaTableViewCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupWith(title: String, poster: UIImage?) {
        self.titleLabel.text = title
        self.posterImage.image = poster
    }
    
}
