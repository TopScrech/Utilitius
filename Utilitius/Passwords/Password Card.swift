import SwiftUI

struct PasswordCard: View {
    @Bindable private var password: Password
    
    init(_ password: Password) {
        self.password = password
    }
    
    var body: some View {
        NavigationLink {
            PasswordView(password)
        } label: {
            VStack(alignment: .leading) {
                Text(password.name)
            }
        }
    }
}

#Preview {
    PasswordCard(.init(name: "Preview"))
}
