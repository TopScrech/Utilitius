import SwiftData

@Model
final class Reminder {
    var name = "New Reminder"
    var note = ""
    var isCompleted = false
    var isFlagged = false
    
    init(_ name: String = "New Reminder") {
        self.name = name
    }
}
