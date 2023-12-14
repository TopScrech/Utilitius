import SwiftUI

struct StopwatchButton <Style: ShapeStyle> : View {
    private let name: String
    private let foreground: Style
    private let background: Color
    private let size: CGFloat
    private let action: () -> Void
    
    init(
        _ name: String,
        foreground: Style,
        background: Color,
        size: CGFloat,
        action: @escaping () -> Void
    ) {
        self.name = name
        self.foreground = foreground
        self.background = background
        self.size = size
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(name)
                .footnote()
                .foregroundStyle(foreground)
        }
        .buttonStyle(.borderless)
        .frame(width: size, height: size)
        .background(background, in: .circle)
    }
}

#Preview {
    VStack {
        StopwatchButton("Preview", foreground: .ultraThinMaterial, background: .red.opacity(0.25), size: 64) {}
    }
}
