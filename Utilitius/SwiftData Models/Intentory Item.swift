import SwiftData

@Model
final class InventoryItem {
    var name = "New Item"
    var itemDescription = ""
    var count = 0
    
    @Relationship(inverse: \Tag.inventoryItems)
    var tags: [Tag]? = []
    
    init(name: String = "New Item") {
        self.name = name
    }
}
