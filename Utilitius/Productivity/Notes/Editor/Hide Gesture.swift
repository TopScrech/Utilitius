import SwiftUI

struct SwipeToHideModifier: ViewModifier {
    @Binding var isVisible: Bool
    
    init(_ isVisible: Binding<Bool>) {
        _isVisible = isVisible
    }
    
    func body(content: Content) -> some View {
        content
            .gesture(
                DragGesture(minimumDistance: 50, coordinateSpace: .local)
                    .onEnded { value in
                        if value.translation.height < 0 {
                            withAnimation {
                                isVisible = false
                            }
                        }
                    }
            )
    }
}

extension View {
    func swipeToHide(_ isVisible: Binding<Bool>) -> some View {
        self
            .modifier(SwipeToHideModifier(isVisible))
    }
}
