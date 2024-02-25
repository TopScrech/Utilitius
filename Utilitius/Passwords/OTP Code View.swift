import SwiftUI

struct OTPCodeView: View {
    @Bindable private var password: Password
    
    init(_ password: Password) {
        self.password = password
    }
    
    var body: some View {
        VStack {
            Text("Password")
            
            if let secret = password.secret {
                OtpView(secret)
            } else {
                Button("Setup") {
                    
                }
            }
        }
    }
}

//#Preview {
//    OTPCodeView(.)
//}
