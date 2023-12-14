import SwiftUI
import SwiftData

struct ReminderList: View {
    @Environment(\.modelContext) private var modelContext
    @Query(animation: .default) private var reminders: [Reminder]
    
    @AppStorage("showCompleted") private var showCompleted = false
    
    var filteredTasks: [Reminder] {
        if showCompleted {
            reminders
        } else {
            reminders.filter {
                !$0.isCompleted
            }
        }
    }
    
    var body: some View {
        List {
            if reminders.isEmpty {
                ContentUnavailableView {
                    Image(systemName: "checklist")
                        .title()
                    
                    Text("No reminders yet")
                } actions: {
                    Button {
                        addItem()
                    } label: {
                        Text("New Reminder")
                            .bold()
                            .padding(12)
                            .foregroundStyle(.white)
                            .background(.blue, in: .rect(cornerRadius: 16))
                    }
                    .padding()
                    .buttonStyle(.borderless)
                    .foregroundStyle(.foreground)
                }
            } else {
                Section {
                    Button {
                        addItem()
                    } label: {
                        Text("New Reminder")
                            .bold()
                            .padding(12)
                    }
                    .buttonStyle(.borderless)
                    .foregroundStyle(.blue)
                }
                
                ForEach(filteredTasks) { reminder in
                    ReminderCard(reminder)
                }
                .onDelete(perform: deleteItems)
            }
        }
    }
    
    private func addItem() {
        let newItem = Reminder()
        modelContext.insert(newItem)
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(reminders[index])
        }
    }
}

#Preview {
    NavigationView {
        ReminderList()
    }
    .modelContainer(for: Reminder.self, inMemory: true)
}
