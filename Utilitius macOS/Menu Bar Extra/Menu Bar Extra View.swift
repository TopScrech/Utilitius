import SwiftUI
import SwiftData

struct MenuBarExtraView: View {
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
            
            Button("Export Array") {
                saveToFile()
                //                let array = items.map {
                //                    $0.content
                //                }
                //                
                //                document.text = array.joined(separator: "\n")
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
    
    func saveToFile() {
        let array = items.map {
            $0.content
        }
        
        let panel = NSSavePanel()
        panel.canCreateDirectories = true
        panel.allowedContentTypes = [.text]
        panel.directoryURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first
        panel.nameFieldStringValue = "ExportedFile.txt"
        
        panel.begin { response in
            if response == .OK {
                document.text = array.joined(separator: "\n")
                if let url = panel.url {
                    try? document.text.write(to: url, atomically: true, encoding: .utf8)
                }
            }
        }
    }
}

#Preview {
    MenuBarExtraView()
}
