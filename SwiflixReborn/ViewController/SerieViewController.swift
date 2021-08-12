//
//  SerieViewController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 12/08/21.
//

import UIKit

class SerieViewController: UIViewController {

    @IBOutlet weak var serieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSerieTableView()

    }
    
    func setupSerieTableView() {
        self.serieTableView.register(UINib(nibName: "MediaTableViewCell", bundle: nil), forCellReuseIdentifier: MediaTableViewCell.customIdentifier)
        
        self.serieTableView.delegate = self
        self.serieTableView.dataSource = self
    }
    
    func showSerieDetails(_ serie: (String?, UIImage?)) {
        self.performSegue(withIdentifier: "SeriesToDetail", sender: serie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        default:
            guard let detail = segue.destination as? SerieDetailViewController,
                  let serie = sender as? (String?, UIImage?) else { return }
            detail.setup(with: serie)
        }
    }

}

extension SerieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? MediaTableViewCell else { return }
        self.showSerieDetails((cell.titleLabel.text, cell.posterImage.image))
    }
    
}

extension SerieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell else { return UITableViewCell() }
        cell.setupWith(title: "Serie Exemplo", poster: UIImage(systemName: "chevron.right"))
        return cell
    }
    
    
}
