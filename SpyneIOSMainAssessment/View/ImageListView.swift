import SwiftUI

struct ImageListView: View {
    @StateObject var viewModel = ImageListViewModel()

    var body: some View {
        List(viewModel.images) { image in
            HStack {
                Image(uiImage: UIImage(contentsOfFile: image.imagePath) ?? UIImage())
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(8)
                VStack(alignment: .leading) {
                    Text(image.imageName)
                    Text("Status: \(image.uploadStatus)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
                ProgressView(value: viewModel.progress(for: image))
                    .frame(width: 100)
            }
        }
        .onAppear {
            viewModel.fetchImages()
        }
    }
}
