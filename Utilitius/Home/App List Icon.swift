import SwiftUI

struct AppListIcon: View {
    private let name: String
    private let renderingMode: SymbolRenderingMode
    
    init(
        _ name: String,
        renderingMode: SymbolRenderingMode = .multicolor
    ) {
        self.name = name
        self.renderingMode = renderingMode
    }
    
    var body: some View {
        Image(systemName: name)
            .largeTitle()
            .symbolRenderingMode(renderingMode)
            .frame(width: 64, height: 64)
            .background(.ultraThinMaterial, in: .rect(cornerRadius: 16))
    }
}

#Preview {
    AppListIcon("stopwatch", renderingMode: .multicolor)
}
