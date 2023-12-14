import SwiftUI
import QuickLook

struct NotesQuickLookView: UIViewControllerRepresentable {
    private let data: Data
    private let fileName: String
    
    init(data: Data, fileName: String) {
        self.data = data
        self.fileName = fileName
    }
    
    func makeUIViewController(context: Context) -> QLPreviewController {
        let controller = QLPreviewController()
        controller.dataSource = context.coordinator
        
        return controller
    }
    
    func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, QLPreviewControllerDataSource {
        private var parent: NotesQuickLookView
        
        init(_ parent: NotesQuickLookView) {
            self.parent = parent
        }
        
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int { 1 }
        
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            let tempURL = URL(fileURLWithPath: NSTemporaryDirectory())
                .appendingPathComponent(parent.fileName)
            
            // Writing the data to a temporary file
            do {
                try parent.data.write(to: tempURL)
            } catch {
                print("Error writing the file: \(error.localizedDescription)")
            }
            
            return tempURL as QLPreviewItem
        }
    }
}
