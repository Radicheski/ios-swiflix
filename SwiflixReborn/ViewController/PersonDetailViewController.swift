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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
