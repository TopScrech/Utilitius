import SwiftUI

struct RemindersUnavailibleView: View {
    private let action: () -> Void
    
    init(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        ContentUnavailableView {
            Label("No reminders yet", systemImage: "checklist")
                .largeTitle()
        } description: {
            Text("Preview")
        } actions: {
            Button {
                action()
            } label: {
                Text("New Reminder")
                    .bold()
                    .padding(12)
                    .foregroundStyle(.white)
                    .background(.blue, in: .rect(cornerRadius: 16))
            }
            .foregroundStyle(.foreground)
        }
    }
}

#Preview {
    RemindersUnavailibleView {
        
    }
}
