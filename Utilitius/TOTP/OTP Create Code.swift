import SwiftUI

struct OTPCreateCode: View {
    @State private var newKey = ""
    
    var body: some View {
        VStack {
            TextField("Key", text: $newKey)
                .autocorrectionDisabled()
            
            Button {
                
            } label: {
                Text("Paste")
            }
            
            Button {
                
            } label: {
                Text("Scan QR")
            }
            
            Spacer()
            
            Button {
                
            } label: {
                Text("Save")
            }
        }
    }
}

#Preview {
    OTPCreateCode()
}
