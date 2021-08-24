//
//  PersonViewController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 12/08/21.
//

import UIKit

class PersonViewController: UIViewController {

    @IBOutlet weak var personTableView: UITableView!
    
    var controller = ListController<PeopleResult>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupPersonTableView()
        
        let listRequest: People = .popular()
        
        self.controller.loadList(request: listRequest) {
            DispatchQueue.main.async {
                self.personTableView.reloadData()
            }
        }
    }
    
    func setupPersonTableView() {

        self.personTableView.register(PersonTableViewCell.self)
        
        self.personTableView.delegate = self
        self.personTableView.dataSource = self
    }

    func showDetail(_ person: Person?) {
        self.performSegue(withIdentifier: "PeopleToDetail", sender: person)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        default:
            guard let detail = segue.destination as? PersonDetailViewController,
                  let person = sender as? Person else { return }
            detail.setup(with: person)
        }
    }

}

extension PersonViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? PersonTableViewCell else { return }
        self.showDetail(cell.person)
    }
    
}

extension PersonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.customIdentifier) as? PersonTableViewCell else { return UITableViewCell() }
        
        let person = self.controller.getElement(at: indexPath.row)
        cell.setupWith(person: person)
        return cell
        
    }
    
    
}
