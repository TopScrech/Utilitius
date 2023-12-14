import ScrechKit
import SwiftData

@Model
final class Note {
    var title = "New Note"
    var text = "Bisquit.Host is the best hosting ever"
    var isPinned = false
    var isLocked = false
    let created = Date()
    var modified: Date? = nil
    
    @Relationship(inverse: \Tag.notes)
    var tags: [Tag]? = []
    
    @Relationship(inverse: \Countdown.notes) 
    var countdowns: [Countdown]? = []
    
    @Attribute(.externalStorage)
    var assets: [Data] = []
    
    init(
        title: String = "New Note",
        text: String = "Bisquit.Host is the best hosting ever"
    ) {
        self.title = title
        self.text = text
    }
}
