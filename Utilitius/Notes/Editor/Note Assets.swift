import ScrechKit
import PhotosUI

struct NoteAssets: View {
    @Bindable private var note: Note
    
    init(_ note: Note) {
        self.note = note
    }
    
    @State private var photoItem: PhotosPickerItem? = nil
    @State private var previewImage: UIImage? = nil
    @State private var isLoading = false
    @State private var showImagePicker = false
    
    var onImageChange: (UIImage) -> () = { image in
        print(image)
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(note.assets.indices, id: \.self) { index in
                    NavigationLink {
                        NotesQuickLookView(data: note.assets[index], fileName: UUID().uuidString + ".jpeg")
                            .ignoresSafeArea()
                    } label: {
                        if let uiImage = UIImage(data: note.assets[index]) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 16))
                                .contextMenu {
                                    MenuButton("Delete", role: .destructive, icon: "trash") {
                                        note.assets.remove(at: index)
                                    }
                                }
                        } else {
                            Image(systemName: "doc")
                        }
                    }
                }
                .animation(.default, value: note.assets)
                
                Button {
                    showImagePicker = true
                } label: {
                    Image(systemName: "plus")
                        .fontSize(40)
                        .foregroundStyle(.white)
                        .frame(width: 80, height: 100)
                        .background(.blue.gradient, in: .rect(cornerRadius: 16))
                }
                .photosPicker(isPresented: $showImagePicker, selection: $photoItem, matching: .images)
            }
        }
        .padding(.horizontal, 5)
        .frame(height: 100)
        .onChange(of: photoItem) { oldValue, newValue in
            if let newValue {
                extractImage(newValue/*, size*/)
            }
        }
    }
    
    func extractImage(
        _ photoItem: PhotosPickerItem//,
        //        _ viewSize: CGSize
    ) {
        Task.detached {
            guard let imageData = try? await photoItem.loadTransferable(type: Data.self) else {
                return
            }
            
            // UI Must be Updated on Main Thread
            await MainActor.run {
                if let selectedImage = UIImage(data: imageData) {
                    generateImageThumbnail(selectedImage/*, viewSize*/)
                    
                    onImageChange(selectedImage)
                }
                
                self.photoItem = nil
            }
        }
    }
    
    func generateImageThumbnail(
        _ image: UIImage//,
        //        _ size: CGSize
    ) {
        isLoading = true
        
        Task.detached {
            let thumbnailImage = await image.byPreparingForDisplay()
            
            //            let thumbnailImage = await image.byPreparingThumbnail(ofSize: size)
            
            await MainActor.run {
                if let data = thumbnailImage?.jpegData(compressionQuality: 1.0) {
                    note.assets.append(data)
                }
                
                previewImage = thumbnailImage
                isLoading = false
            }
        }
    }
}

#Preview {
    NoteAssets(previewNote)
}
