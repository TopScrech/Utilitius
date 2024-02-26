import SwiftUI
import SwiftData

@Observable
final class PasteboardVM {
    private var timer: Timer?
    private let pasteboard = NSPasteboard.general
    var lastCopiedItem: [String] = []
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            
            let currentItems = self.pasteboard.pasteboardItems?.compactMap {
                $0.string(forType: .string)
            } ?? []
            
            if !currentItems.isEmpty {
                lastCopiedItem = currentItems
            }
        }
    }
    
    deinit {
        timer?.invalidate()
    }
}
