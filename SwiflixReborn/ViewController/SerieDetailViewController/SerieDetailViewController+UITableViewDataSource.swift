import UIKit

extension SerieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.selectedSegment {
        
        case .general:
            return 1
            
        case .episodes:
            return self.episodes?.filter({ $0.seasonNumber == section + 1 }).count ?? 0
            
        case .similars:
            return self.similar.count
            
        case .reviews:
            return self.reviews.count
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.selectedSegment {
        
        case .general:
            return 4
            
        case .episodes:
            return self.detail?.numberOfSeasons ?? 1
            
        default:
            return 1
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch self.selectedSegment {
        
        case .general:
            switch section {
            case 0: return "First air date"
            case 1: return "Last air date"
            case 2: return "Number of seasons"
            case 3: return "Number of episodes"
            default: return nil
            }
            
        case .episodes:
            return "Season \(section + 1)"
            
        default:
            return nil
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.selectedSegment {
        
        case .general:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonBiographyTableViewCell.customIdentifier) as? PersonBiographyTableViewCell else { return UITableViewCell() }
            self.setGeneralInformation(cell, for: indexPath)
            return cell
            
        case .episodes:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.customIdentifier) as? EpisodeTableViewCell else { return UITableViewCell() }
            self.setEpisodeInformation(cell, for: indexPath)
            return cell
            
        case .similars:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell else { return UITableViewCell() }
            let media = self.similar.getElement(at: indexPath.row)
            cell.setupWith(media: media)
            return cell
            
        case .reviews:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonBiographyTableViewCell.customIdentifier) as? PersonBiographyTableViewCell else { return UITableViewCell() }
            let review = self.reviews.getElement(at: indexPath.row)
            cell.setup(with: review.content)
            return cell
            
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
    
    func setEpisodeInformation(_ cell: EpisodeTableViewCell, for indexPath: IndexPath) {
        if let season = self.episodes?.filter({ $0.seasonNumber == indexPath.section + 1 }),
           let episode = season.firstIndex(where: { $0.episodeNumber == indexPath.row + 1 }) {
            cell.setup(with: season[episode])
        }
    }
    
    
}
