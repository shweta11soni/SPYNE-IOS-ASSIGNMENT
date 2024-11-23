
import AVFoundation
import UIKit

class CameraViewModel: NSObject {
    private var session: AVCaptureSession?
    private var photoOutput: AVCapturePhotoOutput?
    
    // Setup camera session
    func setupCamera() {
        session = AVCaptureSession()
        guard let session = session else { return }

        // Check if there is a video device (camera)
        guard let videoDevice = AVCaptureDevice.default(for: .video) else {
            print("No video device available")
            return
        }

        do {
            let videoInput = try AVCaptureDeviceInput(device: videoDevice)
            if session.canAddInput(videoInput) {
                session.addInput(videoInput)
                print("Video input added")
            } else {
                print("Failed to add video input")
            }
        } catch {
            print("Error creating video input: \(error.localizedDescription)")
            return
        }

        // Setup photo output
        photoOutput = AVCapturePhotoOutput()
        if let photoOutput = photoOutput, session.canAddOutput(photoOutput) {
            session.addOutput(photoOutput)
            print("Photo output added")
        } else {
            print("Failed to add photo output")
        }

        // Start running the session
        session.startRunning()
        print("Camera setup completed")
    }
    
    // Capture image
    func captureImage(completion: @escaping (UIImage?) -> Void) {
        guard let photoOutput = photoOutput else { return }
        let settings = AVCapturePhotoSettings()
        photoOutput.capturePhoto(with: settings, delegate: self)
    }
}

extension CameraViewModel: AVCapturePhotoCaptureDelegate {
    // This method is called when the photo is captured
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhotoToStorageFileURL fileURL: URL?, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error.localizedDescription)")
            return
        }

        guard let fileURL = fileURL,
              let imageData = try? Data(contentsOf: fileURL),
              let image = UIImage(data: imageData) else {
            print("Error converting photo data to image")
            return
        }

        // Save image path to database
        DatabaseManager.shared.saveImageRecord(imagePath: fileURL.path, imageName: "captured_image", captureDate: Date())
    }
}
