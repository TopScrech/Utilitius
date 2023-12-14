import SwiftUI
import SwiftData

struct SubscriptionsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(animation: .default) private var subscriptions: [Subscription]
    
    var body: some View {
        List {
            ForEach(subscriptions) { subscription in
                Text(subscription.name)
                
                Text(subscription.repeatPeriod.rawValue)
            }
            .onDelete(perform: deleteItems)
            
            Section {
                Button {
                    addItem()
                } label: {
                    Text("Add a new Subscription")
                }
            }
        }
    }
    
    private func addItem() {
        let newItem = Subscription()
        modelContext.insert(newItem)
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(subscriptions[index])
        }
    }
}

#Preview {
    SubscriptionsView()
        .modelContainer(for: Subscription.self, inMemory: true)
}
