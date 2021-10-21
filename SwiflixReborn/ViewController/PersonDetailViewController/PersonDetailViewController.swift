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
        
        if let name = self.detail?.name {
            self.nameLabel.text = name
        }
        
        if let birthday = self.detail?.birthday{
            self.birthdayLabel.text = birthday
            self.birthdayLabel.isHidden = false
        } else {
            self.birthdayLabel.isHidden = true
        }
        
        if let department = self.detail?.knownForDepartment {
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
        
        TMDB.request(request, onSuccess: responseConsumer(entity:), onError: presentError(error:))
        
        let requestCredits: People = .combineCredits(id: .id(person.id))
        
        TMDB.request(requestCredits, onSuccess: responseConsumer(credit:), onError: presentError(error:))
        
        let requestImages: People = .images(id: .id(person.id))
        TMDB.request(requestImages, onSuccess: responseConsumer(image:), onError: presentError(error:))

    }
    
    func presentError(error: Error) {
        let alert: UIAlertController = UIAlertController.buildSimpleInfoAlert(title: "Error", message: error.localizedDescription)
        self.present(alert, animated: true) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
    
    func responseConsumer(entity: PersonEntity) {
        self.detail = entity
        DispatchQueue.main.async {
            self.viewDidLoad()
        }
    }
    
    func responseConsumer(credit: PersonCreditResponse) {
        self.credits = credit.cast
        self.credits.append(contentsOf: credit.crew)
    }
    
    func responseConsumer(image: PersonImagesResponse) {
        self.images = image.profiles
    }
    
    @IBAction func segmentDidSelect(_ sender: UISegmentedControl) {
        self.detailTableView.reloadData()
    }
    
}
