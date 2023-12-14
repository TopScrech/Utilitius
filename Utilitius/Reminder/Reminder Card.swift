import SwiftUI

struct ReminderCard: View {
    @Bindable private var reminder: Reminder
    @Environment(\.editMode) private var editMode
    
    init(_ reminder: Reminder) {
        self.reminder = reminder
    }
    
    var isEditing: Bool {
        if let editMode {
            editMode.wrappedValue.isEditing
        } else {
            false
        }
    }
    
    @State private var sheetInfo = false
    @FocusState private var isFocused
    
    var body: some View {
        HStack {
            if !isEditing {
                Button {
                    withAnimation {
                        reminder.isCompleted.toggle()
                    }
                } label: {
                    if reminder.isCompleted {
                        Image(systemName: "checkmark.circle")
                            .foregroundStyle(.green)
                    } else {
                        Image(systemName: "circle")
                            .foregroundStyle(.secondary)
                    }
                }
                .title2(.semibold)
                .disabled(isFocused)
            }
            
            TextField("", text: $reminder.name)
                .disabled(isEditing)
                .focused($isFocused)
            
            if reminder.isFlagged {
                Image(systemName: "flag.fill")
                    .foregroundStyle(.orange)
            }
            
            if isFocused {
                Button {
                    sheetInfo = true
                } label: {
                    Image(systemName: "info.circle")
                        .foregroundStyle(.blue)
                        .title2()
                }
            }
        }
        .sheet($sheetInfo) {
                Text("Info")
        }
//        .contextMenu {
//            Button {
//                reminder.isFlagged.toggle()
//            } label: {
//                if reminder.isFlagged {
//                    Label("Unflag", systemImage: "flag.slash")
//                } else {
//                    Label("Flag", systemImage: "flag")
//                }
//            }
//        }
    }
}

#Preview {
    NavigationView {
        ReminderParent()
    }
    .modelContainer(for: Reminder.self, inMemory: true)
}
