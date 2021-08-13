//
//  PersonViewController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 12/08/21.
//

import UIKit

class PersonViewController: UIViewController {

    @IBOutlet weak var personTableView: UITableView!
    
    var controller = PersonController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupPersonTableView()
        
        self.controller.loadPeopleList {
            DispatchQueue.main.async {
                self.personTableView.reloadData()
            }
        }
    }
    
    func setupPersonTableView() {
        self.personTableView.register(UINib(nibName: "PersonTableViewCell", bundle: nil), forCellReuseIdentifier: PersonTableViewCell.customIdentifier)
        
        self.personTableView.delegate = self
        self.personTableView.dataSource = self
    }

    func showDetail(_ person: (String?, UIImage?)) {
        self.performSegue(withIdentifier: "PeopleToDetail", sender: person)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        default:
            guard let detail = segue.destination as? PersonDetailViewController,
                  let serie = sender as? (String?, UIImage?) else { return }
            detail.setup(with: serie)
        }
    }

}

extension PersonViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PersonTableViewCell else { return }
        self.showDetail((cell.nameLabel.text, cell.posterImage.image))
    }
    
}

extension PersonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.customIdentifier) as? PersonTableViewCell else { return UITableViewCell() }
        
        let person = self.controller.selectPerson(at: indexPath)
        cell.setupWith(person: person)
        return cell
        
    }
    
    
}
