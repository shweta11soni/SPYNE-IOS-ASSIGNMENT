
import UIKit

class ImageUploader {
    private var imagesToUpload: [UIImage] = []

    func addImageToUpload(image: UIImage) {
        imagesToUpload.append(image)
    }

    func uploadImages(images: [UIImage], completion: @escaping (Bool) -> Void) {
        // Simulate upload delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            completion(true) // Simulated success
        }
    }
}
