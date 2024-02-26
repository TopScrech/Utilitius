import ScrechKit
import SwiftData

struct MenuBarExtraView: View {
    @StateObject private var exporter = TextFileExporter()
    @Environment(PasteboardVM.self) private var pasteboardObserver
    @Environment(\.openWindow) var openWindow
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [PasteboardItem]
    
    @State private var document = TextFile()
    @State private var showTime = false
    
    var body: some View {
        VStack {
            List(items.reversed()) { item in
                Button {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(item.content, forType: .string)
                } label: {
                    Text(item.content)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if showTime {
                        Text(item.date, style: .time)
                            .footnote()
                            .foregroundStyle(.secondary)
                    }
                }
                .buttonStyle(.accessoryBar)
            }
            .scrollIndicators(.never)
            
            Toggle("Show time", isOn: $showTime)
            
            Button("Export") {
                let array = items.map {
                    $0.content
                }
                
                exporter.exportToFile(array)
            }
            .buttonStyle(.plain)
            
            HStack {
                Button("Clear All") {
                    clearAll()
                }
                
                Button("Quit") {
                    NSApplication.shared.terminate(nil)
                }
                
                Button("Open the app") {
                    openWindow(id: "pasteboard")
                }
            }
            .buttonStyle(.plain)
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
}
