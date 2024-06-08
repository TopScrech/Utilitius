import SwiftUI

struct NewPasswordView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var notes = ""
    @State private var password = ""
    @State private var secret = ""
    
    var body: some View {
        VStack(spacing: 40) {
            TextField("Title", text: $title)
            
            TextField("Password", text: $password)
                .textContentType(.password)
                .autocorrectionDisabled()
            
            TextField("OTP Secret", text: $secret)
                .autocorrectionDisabled()
            
            TextEditor(text: $notes)
            
            Spacer()
            
            Button {
                modelContext.insert(
                    Password(
                        name: title,
                        notes: notes,
//                        links: lin,
                        password: password
                    )
                )
                dismiss()
            } label: {
                Text("Add")
                    .foregroundStyle(.white)
                    .title3(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.blue, in: .rect(cornerRadius: 16))
                    .padding(.horizontal)
            }
            .disabled(title.isEmpty)
        }
        .padding(.top, 30)
        .multilineTextAlignment(.center)
    }
}

#Preview {
    NavigationView {
        Text("Preview")
            .sheet {
                NewPasswordView()
            }
    }
}
