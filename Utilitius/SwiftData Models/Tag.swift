import SwiftData

@Model
final class Tag {
    var name = ""
    
    @Relationship
    var notes: [Note]? = []
    
    @Relationship
    var countdowns: [Countdown]? = []
    
    @Relationship
    var inventoryItems: [InventoryItem]? = []
    
    init(_ name: String = "") {
        self.name = name
    }
}
