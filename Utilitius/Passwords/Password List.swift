import SwiftUI
import SwiftData

struct PasswordList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var passwords: [Password]
    
    @State private var sheetNewPassword = false
    
    var body: some View {
        List {
            ForEach(passwords) { password in
                PasswordCard(password)
            }
            .onDelete(perform: deletePassword)
            
            Section {
                Button {
                    sheetNewPassword = true
                } label: {
                    Text("Add new")
                }
            }
        }
        .sheet($sheetNewPassword) {
            NewPasswordView()
        }
    }
    
    private func deletePassword(offsets: IndexSet) {
        for index in offsets {
            let password = passwords[index]
            modelContext.delete(password)
        }
    }
}

#Preview {
    PasswordList()
        .modelContainer(for: Password.self, inMemory: true)
}
