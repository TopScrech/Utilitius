import SwiftUI
import SwiftData

struct ReminderParent: View {
    @Environment(\.modelContext) private var modelContext
    @Query(animation: .default) private var reminders: [Reminder]
    
    var body: some View {
        VStack {
            if reminders.isEmpty {
                RemindersUnavailibleView {
//                    Reminders.create(modelContext)
                    let newItem = Reminder()
                    
                    modelContext.insert(newItem)
                }
            } else {
                ReminderList()
            }
        }
        .navigationTitle("Reminders")
    }
}

#Preview {
    NavigationView {
        ReminderParent()
    }
}
