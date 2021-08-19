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
    
    var serie: Media?
    var detail: SerieDetailResponse?
    var similar: [Media]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDetailTableView()
        
        self.navigationItem.title = self.serie?.mediaTitle ?? "(Unknown title)"
        if let rate = self.detail?.voteAverage {
            self.rateLabel.text = "\(rate)"
        } else {
            self.rateLabel.isHidden = true
        }
        
        TMDB.getImage(size: "w780", string: self.detail?.backdropPath ?? "") { _data in
            if let data = _data,
               let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.backdropImage.image = image
                }
            }
        }
    }
    
    func setupDetailTableView() {
        let cells: [Registrable.Type] = [PersonBiographyTableViewCell.self, MediaTableViewCell.self]
        self.detailTableView.register(cells)
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
    }
    
    func setup(with serie: Media) {
        self.serie = serie
        TMDB.getSerieDetails(id: serie.id) { response in
            self.detail = response
            DispatchQueue.main.async {
                self.viewDidLoad()
            }
        } onError: { error in
            #warning("Handle this error")
        }
        TMDB.getTVSimilar(id: serie.id) { response in
            self.similar = response.results as [Media]
        } onError: { error in
            #warning("Handle this error")
        }


    }
    @IBAction func segmentDidSelect(_ sender: UISegmentedControl) {
        self.detailTableView.reloadData()
    }
    
}

extension SerieDetailViewController: UITableViewDelegate {
    
}

extension SerieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.tabSegment.selectedSegmentIndex {
        case 0:
            return 1
        case 2:
            return self.similar?.count ?? 0
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.tabSegment.selectedSegmentIndex {
        case 0:
            return 4
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch self.tabSegment.selectedSegmentIndex {
        case 0:
            switch section {
            case 0: return "First air date"
            case 1: return "Last air date"
            case 2: return "Number of seasons"
            case 3: return "Number of episodes"
            default: return nil
            }
        default:
            return nil
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tabSegment.selectedSegmentIndex {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonBiographyTableViewCell.customIdentifier) as? PersonBiographyTableViewCell else { return UITableViewCell() }
            self.setGeneralInformation(cell, for: indexPath)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell,
                  let media = self.similar?[indexPath.row] else { return UITableViewCell() }
            cell.setupWith(media: media)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func setGeneralInformation(_ cell: PersonBiographyTableViewCell, for indexPath: IndexPath) {
        switch indexPath.section {
        case SerieGeneralTab.firstAirDate.rawValue:
            cell.setup(with: self.detail?.firstAirDate ?? "No date available")
        case SerieGeneralTab.lastAirDate.rawValue:
            cell.setup(with: self.detail?.lastAirDate ?? "No date available")
        case SerieGeneralTab.numberOfSeasons.rawValue:
            if let seasons = self.detail?.numberOfSeasons {
                cell.setup(with: "\(seasons)")
            }else {
                cell.setup(with: "No information available")
            }
        case SerieGeneralTab.numberOfEpisodes.rawValue:
            if let episodes = self.detail?.numberOfEpisodes {
                cell.setup(with: "\(episodes)")
            }else {
                cell.setup(with: "No information available")
            }
        default:
            return
        }

    }
    
    
}

enum SerieGeneralTab: Int {
    case firstAirDate = 0
    case lastAirDate = 1
    case numberOfSeasons = 2
    case numberOfEpisodes = 3
}
