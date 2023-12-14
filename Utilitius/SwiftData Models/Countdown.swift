import ScrechKit
import SwiftData

@Model
final class Timer {
    var name = "New Сountdown"
    var icon = "⏰"
    var note = ""
    var deadline = Date()
    //    var deadline = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    var attached_url: URL?
    @Relationship(inverse: \Tag.countdowns) var tags: [Tag]? = []
    @Relationship var notes: [Note]? = []
    
    init(
        name: String,
        icon: String,
        note: String,
        attached_url: URL?
    ) {
        self.name = name
        self.icon = icon
        self.note = note
        self.attached_url = attached_url
    }
}
