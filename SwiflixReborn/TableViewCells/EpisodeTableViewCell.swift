//
//  EpisodeTableViewCell.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 19/08/21.
//

import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backdrop: UIImageView!
    @IBOutlet weak var episodeName: UILabel!
    @IBOutlet weak var episodeDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    
    var episode: Episode?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        self.backdrop.image = nil
        self.episodeName.text = nil
        self.episodeName.text = nil
        self.overview.text = nil
    }
    
    func setup(with episode: Episode) {
        self.episode = episode
        self.episodeName.text = episode.name
        self.episodeDate.text = episode.airDate
        self.overview.text = episode.overview
        TMDB.getImage(size: "w154", string: episode.stillPath ?? "") { data in
            if let data = data,
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.backdrop.image = image
                }
            }
        }
    }
    
}

extension EpisodeTableViewCell: Registrable {
    
    static var customIdentifier: String { "EpisodeTableViewCell" }
    static var nib: UINib { UINib(nibName: "EpisodeTableViewCell", bundle: nil) }
    
}
