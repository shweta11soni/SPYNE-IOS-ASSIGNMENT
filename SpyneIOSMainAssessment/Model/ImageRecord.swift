
import RealmSwift

class ImageRecord: Object, Identifiable {
    @objc dynamic var id = UUID().uuidString // it's a unique identifier for each record
    @objc dynamic var imageName = ""
    @objc dynamic var imagePath = ""
    @objc dynamic var captureDate = Date()
    @objc dynamic var uploadStatus = "Pending"
    @objc dynamic var progress: Float = 0.0

    override static func primaryKey() -> String? {
        return "id"
    }
}
