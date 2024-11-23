import UIKit


class ImageListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ImageListCellDelegate{
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = ImageListViewModel()
      var imageRecords: [ImageRecord] = []

      override func viewDidLoad() {
          super.viewDidLoad()
          tableView.delegate = self
          tableView.dataSource = self

          // Register custom cell
          tableView.register(UINib(nibName: "ImageListCell", bundle: nil), forCellReuseIdentifier: "ImageListCell")

          // Load the image records from Realm
          loadImageRecords()
      }

      func loadImageRecords() {
          imageRecords = viewModel.loadImageRecords()
          tableView.reloadData()
      }

      // MARK: - TableView DataSource
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return imageRecords.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageListCell", for: indexPath) as? ImageListCell else {
              return UITableViewCell()
          }
          let record = imageRecords[indexPath.row]
          cell.configure(with: record, delegate: self)
          return cell
      }

      // MARK: - ImageListCellDelegate
      func retryUpload(for record: ImageRecord) {
          let uploader = ImageUploader()

          // Retry upload
          if let image = UIImage(contentsOfFile: record.imagePath) {
              uploader.addImageToUpload(image: image)
              uploader.uploadImages(images: [image]) { success in
                  if success {
                      self.viewModel.updateImageRecord(record: record, uploadStatus: "Uploading", progress: 0.0)
                  } else {
                      self.viewModel.updateImageRecord(record: record, uploadStatus: "Failed", progress: 0.0)
                  }

                  // Reload table data to reflect changes
                  self.loadImageRecords()
              }
          }
      }
  }
