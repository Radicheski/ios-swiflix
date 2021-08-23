//
//  PersonDetailViewController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 12/08/21.
//

import UIKit

class PersonDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var deathdayLabel: UILabel!
    @IBOutlet weak var tabSegment: UISegmentedControl!
    @IBOutlet weak var detailTableView: UITableView!
    
    var person: Person?
    var detail: PersonDetailResponse?
    var credits: [Media] = []
    var images: [Media] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDetailTableView()
        
        self.navigationItem.title = self.person?.name ?? "(Unknown name)"
        
        if let name = self.detail?.name,
           let birthday = self.detail?.birthday,
           let department = self.detail?.knownForDepartment {
            self.nameLabel.text = name
            self.birthdayLabel.text = birthday
            self.departmentLabel.text = department
        }
        
        if let deathday = self.detail?.deathday {
            self.deathdayLabel.text = deathday
            self.deathdayLabel.isHidden = false
        } else {
            self.deathdayLabel.isHidden = true
        }
        
        TMDB.getImage(size: "h632", string: person?.profile ?? "") { _data in
            if let data = _data,
               let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.posterImage.image = image
                }
            }
        }
        
    }
    
    func setupDetailTableView() {

//        self.detailTableView.register(PersonBiographyTableViewCell.self)
//        self.detailTableView.register(MediaTableViewCell.self)
        let cells: [Registrable.Type] = [PersonBiographyTableViewCell.self, MediaTableViewCell.self]
        self.detailTableView.register(cells)
        
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
    }
    
    func setup(with person: Person) {
        
        self.person = person
        
        let request: People = .details(id: .id(person.id))
        
        TMDB.request(url: request.url) { (response: PersonDetailResponse) in
            self.detail = response
            DispatchQueue.main.async {
                self.viewDidLoad()
            }
        } onError: { error in
            #warning("Handle this error")
        }
        
        let requestCredits: People = .combineCredits(id: .id(person.id))
        
        TMDB.request(url: requestCredits.url) { (response: PersonCreditResponse) in
            self.credits = response.cast
            self.credits.append(contentsOf: response.crew)
        } onError: { error in
            #warning("Handle this error")
        }
        
        let requestImages: People = .images(id: .id(person.id))
        TMDB.request(url: requestImages.url) { (response: PersonImagesResponse) in
            self.images = response.profiles
        } onError: { error in
            #warning("Handle this error")
        }

        
    }
    @IBAction func segmentDidSelect(_ sender: UISegmentedControl) {
        self.detailTableView.reloadData()
    }
    
}

extension PersonDetailViewController: UITableViewDelegate {
    
}

extension PersonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (self.tabSegment.selectedSegmentIndex) {
        case 0:
            return 1
        case 1:
            return self.credits.count
        case 2:
            return self.images.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.tabSegment.selectedSegmentIndex {
        case 0:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.tabSegment.selectedSegmentIndex == 0 {
            switch section {
            case BiographySection.biography.rawValue:
                return "Biography"
            case BiographySection.birthPlace.rawValue:
                return "Place of birth"
            default:
                return nil
            }
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if self.tabSegment.selectedSegmentIndex == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: PersonBiographyTableViewCell.customIdentifier) as? PersonBiographyTableViewCell {
                return self.setBiographyViewCell(cell, at: indexPath)
            }
        } else if self.tabSegment.selectedSegmentIndex == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell {
                return self.setCreditsViewCell(cell, at: indexPath)
            }
        } else if self.tabSegment.selectedSegmentIndex == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell {
                let media = self.images[indexPath.row]
                cell.setupWith(media: media)
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func setBiographyViewCell(_ cell: PersonBiographyTableViewCell, at indexPath: IndexPath) -> PersonBiographyTableViewCell {
        
        switch indexPath.section {
        
        case BiographySection.biography.rawValue:
            cell.setup(with: self.detail?.biography ?? "No biography available")
            
        case BiographySection.birthPlace.rawValue:
            cell.setup(with: self.detail?.placeOfBirth ?? "No place of birth available")
            
        default:
            cell.setup(with: "")
            
        }
        
        return cell
        
    }
    
    func setCreditsViewCell(_ cell: MediaTableViewCell, at indexPath: IndexPath) -> MediaTableViewCell {
        
        let media = self.credits[indexPath.row]
        cell.setupWith(media: media)
        
        return cell
    }
    
}

enum BiographySection: Int {
    
    case biography = 0
    case birthPlace = 1
    
}
