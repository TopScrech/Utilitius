import SwiftUI
import SwiftData

struct PasswordList: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var passwords: [Password]
    
    @State private var sheetNewPassword = false
    
    var body: some View {
        List {
            ForEach(passwords) { password in
                OTPCodeView(password)
            }
            
//            NavigationLink("Test code") {
//                OTPCodeView("DRIG5PU6CTAH2MYENGIVF542GZ72PFVJ")
//            }
            
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
}

#Preview {
    PasswordList()
}
