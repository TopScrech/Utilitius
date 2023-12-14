import SwiftUI

struct StopwatchView: View {
    private var stopwatch = StopwatchVM()
    
    var body: some View {
        VStack {
            Text(stopwatch.timeString(stopwatch.timeElapsed))
                .largeTitle()
                .monospaced()
                .numericTransition()
                .animation(.easeOut, value: stopwatch.timeElapsed)
            
            let shortestLap = stopwatch.lapTimes.first {
                $0.time == stopwatch.lapTimes.map { $0.time }.min()
            }
            
            let longestLap = stopwatch.lapTimes.last {
                $0.time == stopwatch.lapTimes.map { $0.time }.max()
            }
            
            List {
                Section {
                    ForEach(stopwatch.lapTimes, id: \.id) { lap in
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
                } header: {
                    if stopwatch.lapTimes.count > 1 {
                        Text("\(stopwatch.lapTimes.count) laps")
                    }
                }
                .animation(.default, value: stopwatch.isRunning)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.bottom)
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button("Lap") {
                    stopwatch.addLap()
                }
                .foregroundStyle(stopwatch.isRunning ? .primary : .secondary)
                .disabled(!stopwatch.isRunning)
                .frame(width: 64, height: 64)
                .background(.ultraThinMaterial, in: .circle)
                
                Spacer()
                
                Group {
                    if stopwatch.isRunning {
                        Button {
                            stopwatch.stop()
                        } label: {
                            Text("Stop")
                                .foregroundStyle(.red)
                                .frame(width: 128, height: 64)
                                .background(.red.gradient.opacity(0.25), in: .capsule)
                        }
                    } else {
                        Button {
                            stopwatch.start()
                        } label: {
                            Text("Start")
                                .foregroundStyle(.green)
                                .frame(width: 128, height: 64)
                                .background(.green.gradient.opacity(0.25), in: .capsule)
                        }
                    }
                }
                .title2(.semibold, design: .monospaced)
                
                Spacer()
                
                Button("Reset") {
                    stopwatch.reset()
                }
                .foregroundStyle(.foreground)
                .frame(width: 64, height: 64)
                .background(.ultraThinMaterial, in: .circle)
            }
            .padding([.horizontal, .bottom])
        }
    }
}

#Preview {
    NavigationView {
        StopwatchView()
    }
}
