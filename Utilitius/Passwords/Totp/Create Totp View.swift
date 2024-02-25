import SwiftUI
import SwiftOTP

struct CreateTotpView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Bindable private var password: Password
    
    init(_ password: Password) {
        self.password = password
    }
    
    @State private var newKey = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Key", text: $newKey)
                    .autocorrectionDisabled()
                    .multilineTextAlignment(.center)
                
                Button {
                    
                } label: {
                    Text("Paste")
                }
            }
            .padding(.horizontal)
            .disabled(true)
            
            Button {
                
            } label: {
                Text("Scan QR")
            }
            .disabled(true)
            
            Spacer()
            
            Button {
                if base32DecodeToData(newKey) != nil {
                    password.secret = newKey
                    dismiss()
                }
            } label: {
                Text("Save")
                    .foregroundStyle(.white)
                    .title3(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.blue, in: .rect(cornerRadius: 16))
                    .padding(.horizontal)
            }
            .disabled(newKey.isEmpty)
        }
        .navigationTitle("Setup TOTP")
    }
}

#Preview {
    CreateTotpView(.init(secret: "DRIG5PU6CTAH2MYENGIVF542GZ72PFVJ"))
}
