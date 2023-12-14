import SwiftUI

struct AppCardSF: View {
    private let name: String
    private let icon: Image
    
    init(
        _ name: String,
        icon: String
    ) {
        self.name = name
        self.icon = Image(systemName: icon)
    }
    
    var body: some View {
        VStack {
            icon
                .largeTitle()
                .frame(width: 64, height: 64)
                .background(.ultraThinMaterial, in: .rect(cornerRadius: 16))
            
            Text(name)
                .rounded()
        }
    }
}

#Preview {
    AppCardSF("Preview", icon: "shippingbox")
}
