import SwiftUI
import SwiftData

struct NFCMessagesView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [NFCMessage]
    
    var body: some View {
        List {
            ForEach(items) { message in
                NFCMessageCard(message)
            }
            .onDelete(perform: deleteItems)
            
            Button("Add") {
                modelContext.insert(NFCMessage("Message \(items.count)", prefix: "https://", value: "bisquit.host"))
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(items[index])
        }
    }
}

#Preview {
    NFCMessagesView()
        .modelContainer(for: NFCMessage.self, inMemory: true)
}
