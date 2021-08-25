import UIKit

extension PersonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.selectedSegment {
        
        case .biography:
            return 1
            
        case .credits:
            return self.credits.count
            
        case .profiles:
            return self.images.count
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.selectedSegment {
        
        case .biography:
            return 2
            
        default:
            return 1
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch self.selectedSegment {
        
        case .biography:
            switch section {
            case BiographySection.biography.rawValue:
                return "Biography"
            case BiographySection.birthPlace.rawValue:
                return "Place of birth"
            default:
                return nil
            }
            
        default:
            return nil
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.selectedSegment {
        
        case .biography:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonBiographyTableViewCell.customIdentifier) as? PersonBiographyTableViewCell else { return UITableViewCell() }
            return self.setBiographyViewCell(cell, at: indexPath)
            
        case .credits:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell else { return UITableViewCell() }
            return self.setCreditsViewCell(cell, at: indexPath)
            
        case .profiles:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell else { return UITableViewCell() }
            let media = self.images[indexPath.row]
            cell.setupWith(media: media)
            return cell
            
        }
        
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
    
    func setCreditsViewCell(_ cell: MediaTableViewCell, at indexPath: IndexPath) -> MediaTableViewCell {
        
        let media = self.credits[indexPath.row]
        cell.setupWith(media: media)
        
        return cell
    }
    
}
