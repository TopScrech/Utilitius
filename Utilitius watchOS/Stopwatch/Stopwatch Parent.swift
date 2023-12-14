import SwiftUI

struct StopwatchParent: View {
    private var stopwatch = StopwatchVM()
    
    var body: some View {
        TabView {
            StopwatchView()
                .tag("Stopwatch")
            
            StopwatchLaps()
                .tag("Laps")
        }
        .environment(stopwatch)
    }
}

#Preview {
    StopwatchParent()
}
