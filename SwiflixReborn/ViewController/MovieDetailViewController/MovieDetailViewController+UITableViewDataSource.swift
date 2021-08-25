import UIKit

extension MovieDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.selectedSegment {
        
        case .general:
            return 1
            
        case .similars:
            return self.similar.count
            
        case .videos:
            return self.videos.count
            
        case .reviews:
            return self.reviews.count
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.selectedSegment {
        
        case .general:
            return 3
            
        default:
            return 1
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch self.selectedSegment {
        
        case .general:
            switch section {
            case MovieGeneralSection.overview.rawValue: return "Overview"
            case MovieGeneralSection.originalTitle.rawValue: return "Original title"
            case MovieGeneralSection.releaseDate.rawValue: return "Release date"
            default: return nil
            }
            
        default:
            return nil
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.selectedSegment {
        
        case .general:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonBiographyTableViewCell.customIdentifier) as? PersonBiographyTableViewCell else { return UITableViewCell() }
            return self.getGeneralIInformation(cell, at: indexPath)
            
        case .similars:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell else { return UITableViewCell() }
            let media = self.similar.getElement(at: indexPath.row)
            cell.setupWith(media: media)
            return cell
            
        case .videos:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell else { return UITableViewCell() }
            let media = self.videos.getElement(at: indexPath.row)
            cell.setupWith(media: media)
            return cell
            
        case .reviews:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonBiographyTableViewCell.customIdentifier) as? PersonBiographyTableViewCell else { return UITableViewCell() }
            let review = self.reviews.getElement(at: indexPath.row)
            cell.setup(with: review.content)
            return cell
            
        }
    }
    
    func getGeneralIInformation(_ cell: PersonBiographyTableViewCell, at indexPath: IndexPath) -> PersonBiographyTableViewCell{
        
        switch indexPath.section {
        case MovieGeneralSection.overview.rawValue:
            cell.setup(with: self.detail?.overview ?? "No overview available")
        case MovieGeneralSection.originalTitle.rawValue:
            cell.setup(with: self.detail?.originalTitle ?? "No orginal title avilable")
        case MovieGeneralSection.releaseDate.rawValue:
            cell.setup(with: self.detail?.releaseDate ?? "No release date available")
        default:
            cell.setup(with: "")
        }
        
        return cell
    }
    
}
