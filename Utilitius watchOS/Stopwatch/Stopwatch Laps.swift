import SwiftUI

struct StopwatchLaps: View {
    @Environment(StopwatchVM.self) private var stopwatch: StopwatchVM
    
    var body: some View {
        let shortestLap = stopwatch.lapTimes.first {
            $0.time == stopwatch.lapTimes.map { $0.time }.min()
        }
        
        let longestLap = stopwatch.lapTimes.last {
            $0.time == stopwatch.lapTimes.map { $0.time }.max()
        }
        
        VStack {
            Text(stopwatch.timeString(stopwatch.timeElapsed))
                .monospaced()
            
            List(stopwatch.lapTimes, id: \.id) { lap in
                HStack {
                    Text("Lap \(lap.index)")
                    
                    Spacer()
                    
                    Text(stopwatch.timeString(lap.time))
                }
                .foregroundStyle(
                    lap.id == longestLap?.id ? .red :
                        lap.id == shortestLap?.id ? .green : .primary
                )
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    StopwatchLaps()
        .environment(StopwatchVM())
}
