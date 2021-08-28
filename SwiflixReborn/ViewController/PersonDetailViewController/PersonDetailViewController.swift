import UIKit

class PersonDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var deathdayLabel: UILabel!
    @IBOutlet weak var tabSegment: UISegmentedControl!
    @IBOutlet weak var detailTableView: UITableView!
    
    var detail: PersonEntity?
    var credits: [Media] = []
    var images: [Media] = []
    
    var selectedSegment: PersonDetailSegment {
        PersonDetailSegment(rawValue: self.tabSegment.selectedSegmentIndex)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupDetailTableView()
        
        self.navigationItem.title = self.detail?.name ?? "(Unknown name)"
        
        if let name = self.detail?.name,
           let birthday = self.detail?.birthday,
           let department = self.detail?.knownForDepartment {
            self.nameLabel.text = name
            self.birthdayLabel.text = birthday
            self.departmentLabel.text = department
        }
        
        if let deathday = self.detail?.deathday {
            self.deathdayLabel.text = deathday
            self.deathdayLabel.isHidden = false
        } else {
            self.deathdayLabel.isHidden = true
        }
        
        TMDB.getImage(size: "h632", string: detail?.posterPath ?? "") { _data in
            if let data = _data,
               let image = UIImage(data: data){
                DispatchQueue.main.async {
                    self.posterImage.image = image
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
    
    func setup(with person: Person) {
        
        let request: People = .details(id: .id(person.id))
        
        TMDB.request(request) { (response: PersonEntity) in
            self.detail = response
            DispatchQueue.main.async {
                self.viewDidLoad()
            }
        } onError: { error in
            #warning("Handle this error")
        }
        
        let requestCredits: People = .combineCredits(id: .id(person.id))
        
        TMDB.request(requestCredits) { (response: PersonCreditResponse) in
            self.credits = response.cast
            self.credits.append(contentsOf: response.crew)
        } onError: { error in
            #warning("Handle this error")
        }
        
        let requestImages: People = .images(id: .id(person.id))
        TMDB.request(requestImages) { (response: PersonImagesResponse) in
            self.images = response.profiles
        } onError: { error in
            #warning("Handle this error")
        }

        
    }
    @IBAction func segmentDidSelect(_ sender: UISegmentedControl) {
        self.detailTableView.reloadData()
    }
    
}
