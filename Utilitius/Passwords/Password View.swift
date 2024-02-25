import SwiftUI

struct PasswordView: View {
    @Bindable private var password: Password
    
    init(_ password: Password) {
        self.password = password
    }
    
    @State private var sheetTotp = false
    
    var body: some View {
        VStack {
            Text("Password")
            
            if let secret = password.secret {
                OtpView(secret)
            } else {
                Button("Setup TOTP") {
                    sheetTotp = true
                }
            }
        }
        .navigationTitle(password.name)
        .sheet($sheetTotp) {
            CreateTotpView(password)
        }
    }
}

#Preview {
    PasswordView(.init(secret: "DRIG5PU6CTAH2MYENGIVF542GZ72PFVJ"))
}
