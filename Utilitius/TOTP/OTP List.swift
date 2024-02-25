import SwiftUI

struct OTPList: View {
    @State private var sheetNewCode = false
    
    var body: some View {
        List {
            NavigationLink("Test code") {
                OTPCodeView("DRIG5PU6CTAH2MYENGIVF542GZ72PFVJ")
            }
            
            Section {
                Button {
                    
                } label: {
                    Text("Add new")
                }
            }
        }
        .sheet($sheetNewCode) {
            
        }
    }
}

#Preview {
    OTPList()
}
