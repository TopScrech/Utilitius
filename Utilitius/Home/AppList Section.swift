import SwiftUI

struct AppList_Section <Content: View>: View {
    private let header: LocalizedStringKey
    private let icon: String
    private let content: Content
    
    init(_ header: LocalizedStringKey, icon: String, @ViewBuilder content: () -> Content) {
        self.header = header
        self.icon = icon
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(header)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .largeTitle(.semibold)
                
                Image(systemName: icon)
                    .title2(.semibold)
                    .foregroundStyle(.blue)
            }
            
            Capsule()
                .frame(width: .infinity, height: 5)
            
            content
        }
        .padding(.bottom)
    }
}

#Preview {
    AppList_Section("Preview", icon: "hammer.fill") {}
        .padding(.horizontal)
}
