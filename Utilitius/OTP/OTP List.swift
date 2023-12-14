import SwiftUI

struct OTPList: View {
    @State private var sheetNewCode = false
    
    var body: some View {
        List {
            NavigationLink("Test code") {
                OTPCodeView("")
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
