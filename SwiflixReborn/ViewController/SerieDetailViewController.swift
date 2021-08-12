//
//  SerieDetailViewController.swift
//  SwiflixReborn
//
//  Created by Erik Radicheski da Silva on 12/08/21.
//

import UIKit

class SerieDetailViewController: UIViewController {
    
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var tabSegment: UISegmentedControl!
    @IBOutlet weak var detailTableView: UITableView!
    
    var serieTitle: String?
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDetailTableView()
        
        self.backdropImage.image = self.image
        self.navigationItem.title = self.serieTitle
    }
    
    func setupDetailTableView() {
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
    }
    
    func setup(with serie: (String?, UIImage?)) {
        self.serieTitle = serie.0
        self.image = serie.1
    }

}

extension SerieDetailViewController: UITableViewDelegate {
    
}

extension SerieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
