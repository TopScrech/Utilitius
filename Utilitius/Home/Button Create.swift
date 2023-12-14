import ScrechKit

struct ButtonCreate: View {
    private let icon: String
    private let action: () -> Void
    
    init(
        _ icon: String = "plus",
        action: @escaping () -> Void = {}
    ) {
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        SFButton(icon) {
            action()
        }
        .frame(width: 20, height: 20)
        .padding()
        .title2(.semibold)
        .foregroundStyle(.yellow)
        .background(.ultraThickMaterial, in: .circle)
        .padding()
    }
}

#Preview {
    ButtonCreate()
}
