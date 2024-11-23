
import Foundation
import RealmSwift

class DatabaseManager {
    static let shared = DatabaseManager()
    private var realm: Realm
    
    private init() {
        do {
            realm = try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error.localizedDescription)")
        }
    }
    
    // Fetch all image records
    func fetchAllImageRecords() -> [ImageRecord] {
        let results = realm.objects(ImageRecord.self)
        return Array(results)
    }
    
    // Save new image record
    func saveImageRecord(imagePath: String, imageName: String, captureDate: Date) {
        let newImageRecord = ImageRecord()
        newImageRecord.imagePath = imagePath
        newImageRecord.imageName = imageName
        newImageRecord.captureDate = captureDate
        
        do {
            try realm.write {
                realm.add(newImageRecord)
            }
        } catch {
            print("Error saving image record: \(error.localizedDescription)")
        }
    }
    
    // Update image record's upload status and progress
    func updateImageRecord(id: String, status: String, progress: Float) {
        if let imageRecord = realm.object(ofType: ImageRecord.self, forPrimaryKey: id) {
            do {
                try realm.write {
                    imageRecord.uploadStatus = status
                    imageRecord.progress = progress
                }
            } catch {
                print("Error updating image record: \(error.localizedDescription)")
            }
        }
    }
    
    // Delete an image record
    func deleteImageRecord(id: String) {
        if let imageRecord = realm.object(ofType: ImageRecord.self, forPrimaryKey: id) {
            do {
                try realm.write {
                    realm.delete(imageRecord)
                }
            } catch {
                print("Error deleting image record: \(error.localizedDescription)")
            }
        }
    }
}
