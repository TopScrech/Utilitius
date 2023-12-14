import SwiftUI
import SwiftData

final class Reminders {
    static func create(_ modelContext: ModelContext) {
        let newItem = Reminder()
        
        modelContext.insert(newItem)
    }
}
