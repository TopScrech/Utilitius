import SwiftUI

struct ApplistCard: View {
    private let title, description: LocalizedStringKey
    private let action: () -> Void
    
    init(
        _ title: LocalizedStringKey,
        description: LocalizedStringKey,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.description = description
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 2) {
                Text(title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
            }
            .rounded()
            .padding()
            .background(.ultraThinMaterial, in: .rect(cornerRadius: 16))
        }
    }
}

#Preview {
    ApplistCard("Preview", description: "Preview description") {}
        .padding(.horizontal)
}

#Preview {
    ApplistCard("Preview", description: "Preview description that is also sooooooooo much loooooong") {}
}
