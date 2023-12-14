import ScrechKit
import SwiftData

struct ReminderList: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.editMode) private var editMode
    @Query(animation: .default) private var reminders: [Reminder]
    
    @AppStorage("showCompleted") private var showCompleted = false
    
    var uncompletedReminders: [Reminder] {
        reminders.filter {
            !$0.isCompleted
        }
    }
    
    var completedReminders: [Reminder] {
        reminders.filter {
            $0.isCompleted
        }
    }
    
    var isEditing: Bool {
        if let editMode {
            editMode.wrappedValue.isEditing
        } else {
            false
        }
    }
    
    var body: some View {
        List {
            if isEditing {
                Text("Editing")
            }
            
            ForEach(uncompletedReminders) { reminder in
                ReminderCard(reminder)
                    .contextMenu {
                        MenuButton("Delete", role: .destructive, icon: "trash") {
                            modelContext.delete(reminder)
                        }
                    }
            }
            //            .onDelete(perform: deleteItems)
            
            if showCompleted {
                Section("Completed") {
                    ForEach(completedReminders) { reminder in
                        ReminderCard(reminder)
                            .contextMenu {
                                MenuButton("Delete", role: .destructive, icon: "trash") {
                                    modelContext.delete(reminder)
                                }
                            }
                    }
                    //                    .onDelete(perform: deleteItems)
                }
            }
        }
        .animation(.default, value: reminders)
        .listStyle(.plain)
        .toolbar {
            Menu {
//                EditButton()
                
                Button {
                    withAnimation {
                        showCompleted.toggle()
                    }
                } label: {
                    if showCompleted {
                        Label("Hide Completed", systemImage: "eye.slash")
                    } else {
                        Label("Show Completed", systemImage: "eye")
                    }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
            .disabled(reminders.isEmpty)
        }
        .overlay(alignment: .bottomTrailing) {
            ButtonCreate("plus") {
                Reminders.create(modelContext)
            }
            .foregroundStyle(.red)
        }
    }
    
    //    private func deleteItems(offsets: IndexSet) {
    //        for index in offsets {
    //            modelContext.delete(reminders[index])
    //        }
    //    }
}

#Preview {
    NavigationView {
        ReminderParent()
    }
    .modelContainer(for: Reminder.self, inMemory: true)
}
