
import RealmSwift
import Combine

class ImageListViewModel: ObservableObject {
    @Published var images: [ImageRecord] = []

    private var realm: Realm {
        return try! Realm()
    }

    // Method to fetch all image records from Realm
    func loadImageRecords() -> [ImageRecord] {
         return Array(realm.objects(ImageRecord.self))
     }

     func updateImageRecord(record: ImageRecord, uploadStatus: String, progress: Float) {
         try! realm.write {
             record.uploadStatus = uploadStatus
             record.progress = progress
         }
     }

    // Fetch image records and update images property
    func fetchImages() {
        loadImageRecords()
    }

    // Method to get progress for a specific image
    func progress(for image: ImageRecord) -> Float {
        return image.progress
    }
}
