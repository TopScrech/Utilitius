import SwiftUI
import SwiftData

struct PasteboardList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [PasteboardItem]
    
    @Environment(PasteboardVM.self) private var pasteboardObserver
    
    var body: some View {
        List {
            ForEach(items.reversed()) { item in
                Button {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(item.content, forType: .string)
                } label: {
                    Text(item.content)
                        .lineLimit(1)
                }
                .buttonStyle(.plain)
            }
            
            //            Section {
            //                Button {
            //                    NSPasteboard.general.setString("qefewfew", forType: .string)
            //                } label: {
            //                    Text("Clear")
            //                }
            //            }
        }
        .onChange(of: pasteboardObserver.lastCopiedItem) { _, newValue in
            if items.last?.content != newValue.first {
                appendNewItems(newValue)
            }
        }
    }
    
    private func appendNewItems(_ newItems: [String]) {
        for item in newItems {
            modelContext.insert(PasteboardItem(content: item, date: Date()))
        }
    }
}

#Preview {
    PasteboardList()
}
