import SwiftUI

struct InventoryCard: View {
    private let item: InventoryItem
    
    init(_ item: InventoryItem) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(item.name)
                
                Spacer()
                
                Text(item.count)
            }
            
            Text(item.itemDescription)
        }
    }
}

#Preview {
    List {
        InventoryCard(
            .init(name: "Preview")
        )
    }
}
