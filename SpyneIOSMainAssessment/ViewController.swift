

import UIKit
import AVFoundation


class ViewController: UIViewController {
    private var cameraViewModel = CameraViewModel()
   
    @IBOutlet var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Check if camera permission is granted
          checkCameraPermission()
          
          // Setup the camera after permission check
          cameraViewModel.setupCamera()
    }

    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // Permission granted
            print("Camera access authorized")
        case .notDetermined:
            // Request permission
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    print("Camera access granted")
                } else {
                    print("Camera access denied")
                }
            }
        case .denied, .restricted:
            print("Camera access denied or restricted")
        @unknown default:
            fatalError("Unknown camera permission status")
        }
    }

    @IBAction func cameraButtonTapped(_ sender: Any) {
        cameraViewModel.captureImage { image in
            if let image = image {
                let imagePath = "path/to/image"  // Replace with actual image path
                print("Image captured")
                DatabaseManager.shared.saveImageRecord(imagePath: imagePath, imageName: "captured_image", captureDate: Date())
            }
        }
    }
}
     
