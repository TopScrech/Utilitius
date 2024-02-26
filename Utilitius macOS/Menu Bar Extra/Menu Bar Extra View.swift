import ScrechKit
import SwiftData

struct MenuBarExtraView: View {
    @StateObject private var exporter = TextFileExporter()
    @EnvironmentObject private var settings: SettingsStorage
    @Environment(PasteboardVM.self) private var pasteboardObserver
    @Environment(\.openWindow) var openWindow
    @Environment(\.dismissWindow) var dismissWindow
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [PasteboardItem]
    
    @State private var document = TextFile()
    
    var body: some View {
        VStack {
            List(items.reversed()) { item in
                PasteboardCard(item)
            }
            .scrollIndicators(.never)
            
            Toggle("Show time", isOn: $settings.showTime)
            
            HStack {
                Button("Clear All") {
                    clearAll()
                }
                
                Button("Export") {
                    let array = items.map {
                        $0.content
                    }
                    
                    exporter.exportToFile(array)
                }
                
                Button("Quit", role: .destructive) {
                    NSApplication.shared.terminate(nil)
                }
            }
            
            HStack {
                Button("Open window") {
                    openWindow(id: "pasteboard")
                }
                
                Button("Dismiss window") {
                    dismissWindow(id: "pasteboard")
                }
            }
            .padding(.bottom)
        }
    }
    
    private func clearAll() {
        for item in items {
            modelContext.delete(item)
        }
    }
}

final class TextFileExporter: ObservableObject {
    private let panel = NSSavePanel()
    
    func exportToFile(_ array: [String]) {
        main {
            self.setupSavePanel()
            
            if self.panel.runModal() == .OK {
                self.writeToFile(array, url: self.panel.url)
            }
        }
    }
    
    private func setupSavePanel() {
        panel.allowedContentTypes = [.text]
        panel.directoryURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first
        panel.nameFieldStringValue = "ExportedFile.txt"
    }
    
    private func writeToFile(_ array: [String], url: URL?) {
        guard let url else { return }
        
        let text = array.joined(separator: "\n")
        
        do {
            try text.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            print("Failed to write to file: \(error)")
        }
    }
}

#Preview {
    MenuBarExtraView()
        .environment(PasteboardVM())
        .environmentObject(SettingsStorage())
}
