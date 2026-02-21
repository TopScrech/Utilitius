import SwiftUI

struct InventoryItem_View: View {
    @Bindable private var item: InventoryItem
    
    init(_ item: InventoryItem) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            Text(item.name)
            
            TextField("Description", text: $item.itemDescription)
                .multilineTextAlignment(.center)
            
            Text(item.count, format: .number)
                .animation(.default, value: item.count)
                .numericTransition()
                .monospaced()
                .semibold()
            
            Group {
                HStack {
                    Button("+1") {
                        item.count += 1
                    }
                    
                    Button("+5") {
                        item.count += 5
                    }
                    
                    Button("+10") {
                        item.count += 10
                    }
                    
                    Button("+25") {
                        item.count += 25
                    }
                    
                    Button("+100") {
                        item.count += 100
                    }
                }
                .foregroundStyle(.green)
                
                HStack {
                    Button("-1") {
                        item.count -= 1
                    }
                    
                    Button("-5") {
                        item.count -= 5
                    }
                    
                    Button("-10") {
                        item.count -= 10
                    }
                    
                    Button("-25") {
                        item.count -= 25
                    }
                    
                    Button("-100") {
                        item.count -= 100
                    }
                }
                .foregroundStyle(.red)
            }
            .buttonStyle(.bordered)
        }
    }
}

//#Preview {
//    InventoryItem_View(previewInventoryItem)
//        .modelContainer(for: InventoryItem.self, inMemory: true)
//}
