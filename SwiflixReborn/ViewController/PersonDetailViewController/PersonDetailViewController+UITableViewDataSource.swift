import UIKit

extension PersonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (self.tabSegment.selectedSegmentIndex) {
        case 0:
            return 1
        case 1:
            return self.credits.count
        case 2:
            return self.images.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.tabSegment.selectedSegmentIndex {
        case 0:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if self.tabSegment.selectedSegmentIndex == 0 {
            switch section {
            case BiographySection.biography.rawValue:
                return "Biography"
            case BiographySection.birthPlace.rawValue:
                return "Place of birth"
            default:
                return nil
            }
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if self.tabSegment.selectedSegmentIndex == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: PersonBiographyTableViewCell.customIdentifier) as? PersonBiographyTableViewCell {
                return self.setBiographyViewCell(cell, at: indexPath)
            }
        } else if self.tabSegment.selectedSegmentIndex == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell {
                return self.setCreditsViewCell(cell, at: indexPath)
            }
        } else if self.tabSegment.selectedSegmentIndex == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.customIdentifier) as? MediaTableViewCell {
                let media = self.images[indexPath.row]
                cell.setupWith(media: media)
                return cell
            }
        }
        
        return UITableViewCell()
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
