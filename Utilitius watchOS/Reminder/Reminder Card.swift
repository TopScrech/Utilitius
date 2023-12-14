import SwiftUI

struct ReminderCard: View {
    @Bindable private var reminder: Reminder
    
    init(_ reminder: Reminder) {
        self.reminder = reminder
    }
    
    var body: some View {
        HStack {
            Button {
                reminder.isCompleted.toggle()
            } label: {
                if reminder.isCompleted {
                    Image(systemName: "checkmark.circle")
                        .foregroundStyle(.green)
                } else {
                    Image(systemName: "circle")
                        .foregroundStyle(.secondary)
                }
            }
            .title3(.semibold)
            
            Text(reminder.name)
                .footnote()
        }
    }
}

#Preview {
    ReminderList()
        .modelContainer(for: Reminder.self, inMemory: true)
}
