
import UIKit

protocol ImageListCellDelegate: AnyObject {
    func retryUpload(for record: ImageRecord)
}
class ImageListCell: UITableViewCell {
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!

    weak var delegate: ImageListCellDelegate?
       private var imageRecord: ImageRecord?

       func configure(with record: ImageRecord, delegate: ImageListCellDelegate) {
           self.imageRecord = record
           self.delegate = delegate

           // Set the image thumbnail
           if let image = UIImage(contentsOfFile: record.imagePath) {
               thumbnailImageView.image = image
           } else {
               thumbnailImageView.image = UIImage(named: "placeholder") // Placeholder
           }

           // Set progress and status
           progressBar.progress = record.progress
           statusLabel.text = "Status: \(record.uploadStatus)"

           // Retry button visibility
           retryButton.isHidden = record.uploadStatus == "Success"
       }

    @IBAction func retryUpload(_ sender: UIButton) {
        if let record = imageRecord {
                   delegate?.retryUpload(for: record)
               }
           }
}
