import SwiftUI
import SwiftData

struct MultiboardList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [MultiboardItem]
    
    var body: some View {
        List {
            ForEach(items) { item in
                MultiboardCard(item)
            }
            
            Section {
                Button("Add") {
                    createItem()
                }
            }
        }
    }
    
    func createItem() {
        modelContext.insert(
            MultiboardItem("New item", content: "", createdAt: Date())
        )
    }
}

#Preview {
    MultiboardList()
        .modelContainer(for: MultiboardItem.self, inMemory: true)
}
