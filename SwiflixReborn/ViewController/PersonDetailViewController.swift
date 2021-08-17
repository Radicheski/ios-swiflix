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
        self.detailTableView.register(UINib(nibName: "PersonBiographyTableViewCell", bundle: nil), forCellReuseIdentifier: PersonBiographyTableViewCell.customIdentifier)
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
    }

    func setup(with person: Person) {
        
        self.person = person
        
        TMDB.getPersonDetails(id: person.id) { response in
            self.detail = response
            DispatchQueue.main.async {
                self.viewDidLoad()
            }
        } onError: { error in
            #warning("Handle this error")
        }
        
    }

}

extension PersonDetailViewController: UITableViewDelegate {
    
}

extension PersonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.tabSegment.selectedSegmentIndex == 0 { return 2 }
        return 0
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonBiographyTableViewCell.customIdentifier) as? PersonBiographyTableViewCell else { return UITableViewCell() }
        
        if self.tabSegment.selectedSegmentIndex == 0 {
            return self.setBiographyViewCell(cell, at: indexPath)
        }
        
        return cell
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
    
}

enum BiographySection: Int {
    
    case biography = 0
    case birthPlace = 1
    
}
