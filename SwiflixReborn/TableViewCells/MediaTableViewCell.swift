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
    
    var media: Media?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupWith(media: Media) {
        self.media = media
        self.titleLabel.text = media.mediaTitle
        self.posterImage.image = UIImage(systemName: "film")
        TMDB.getImage(string: media.poster) { _data in
            if let data = _data,
               let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.posterImage.image = image
                }
            }
        }
    }
    
}
