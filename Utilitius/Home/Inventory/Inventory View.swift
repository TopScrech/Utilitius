import SwiftUI
import SwiftData

struct InventoryView: View {
    @Environment(NavState.self) private var navState
    @Environment(\.modelContext) private var modelContext
    @Query(animation: .default) private var items: [InventoryItem]
    
    var body: some View {
        TabView {
            if items.isEmpty {
                ContentUnavailableView(
                    "No existing items",
                    systemImage: "shippingbox",
                    description: Text("Tap on \"Add\" button to add an item")
                )
                .symbolEffect(.pulse)
            } else {
                List {
                    ForEach(items) { item in
                        Button {
                            navState.navigate(.toInventoryItem(item))
                        } label: {
                            Text(item.name)
                        }
                        .foregroundStyle(.foreground)
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            
            Text("Tags")
        }
        .tabViewStyle(.page)
        .navigationTitle("Inventory")
        .toolbar {
            Button {
                modelContext.insert(InventoryItem())
            } label: {
                Image(systemName: "plus")
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
    InventoryView()
        .modelContainer(for: InventoryItem.self, inMemory: true)
}
