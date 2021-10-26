import FirebaseFirestore
import FirebaseAuth

class Database {
    
    static let shared = Database()
    
    private init() {}
    
    let db = FirebaseFirestore.Firestore.firestore()
    let auth = Auth.auth()
    
    func setFavorite(type: String, data: Entity, onSuccess: (() -> Void)?, onError: ((Error) -> Void)?) {
        guard let uid = auth.currentUser?.uid else { return }
        var dict: [String: Any] = [:]
        dict["id"] = data.id
        dict["title"] = data.name
        dict["poster"] = data.posterPath
        db.collection("users").document(uid).collection("favorite").document("\(type)-\(data.id)").setData(dict) { error in
            if let error = error {
                onError?(error)
            } else {
                onSuccess?()
            }
        }
    }
    
}
