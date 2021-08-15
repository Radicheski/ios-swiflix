//
//  SerieViewController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 12/08/21.
//

import UIKit

class SerieViewController: UIViewController {

    @IBOutlet weak var serieTableView: UITableView!
    
    var controller = SerieController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSerieTableView()
        
        self.controller.loadSerieList {
            DispatchQueue.main.async {
                self.serieTableView.reloadData()
            }
        }

    }
    
    func setupSerieTableView() {
        self.serieTableView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: MediaTableViewCell.customIdentifier)
        
        self.serieTableView.delegate = self
        self.serieTableView.dataSource = self
    }
    
    func showSerieDetails(_ serie: Media?) {
        self.performSegue(withIdentifier: "SeriesToDetail", sender: serie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        default:
            guard let detail = segue.destination as? SerieDetailViewController,
                  let serie = sender as? Media else { return }
            detail.setup(with: serie)
        }
    }

}

extension SerieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MediaTableViewCell else { return }
        self.showSerieDetails(cell.media)
    }
    
}

extension SerieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.controller.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell else { return UITableViewCell() }
        
        let media = self.controller.selectSerie(at: indexPath)
        
        cell.setupWith(media: media)
        return cell
    }
    
    
}
