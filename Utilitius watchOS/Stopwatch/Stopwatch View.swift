import SwiftUI

struct StopwatchView: View {
    private var stopwatch = StopwatchVM()
    
    var body: some View {
        VStack {
            Text(stopwatch.timeString(stopwatch.timeElapsed))
                .minimumScaleFactor(0.25)
                .scaledToFit()
                .largeTitle(design: .monospaced)
                .numericTransition()
                .animation(.easeOut, value: stopwatch.timeElapsed)
            
            Spacer()
            
            HStack {
                StopwatchButton("Lap", foreground: stopwatch.isRunning ? .white : .secondary, background: .gray.opacity(0.25), size: 50) {
                    stopwatch.addLap()
                }
                .disabled(!stopwatch.isRunning)
                
                Spacer()
                
                if stopwatch.isRunning {
                    StopwatchButton("Stop", foreground: .red, background: .red.opacity(0.25), size: 50) {
                        stopwatch.stop()
                    }
                } else {
                    StopwatchButton("Start", foreground: .green, background: .green.opacity(0.25), size: 50) {
                        stopwatch.start()
                    }
                }
                
                Spacer()
                
                StopwatchButton("Reset", foreground: .foreground, background: .gray.opacity(0.25), size: 50) {
                    stopwatch.reset()
                }
            }
            .animation(.default, value: stopwatch.isRunning)
            .padding(.horizontal)
        }
    }
}

#Preview {
    StopwatchView()
}
