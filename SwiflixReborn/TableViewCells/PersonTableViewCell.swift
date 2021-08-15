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
    
    var person: Person?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupWith(person: Person) {
        self.person = person
        self.nameLabel.text = person.name
        self.posterImage.image = UIImage(systemName: "person")
        TMDB.getImage(string: person.profile ?? "") { _data in
            if let data = _data,
               let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.posterImage.image = image
                }
            }
        }
    }
    
}
