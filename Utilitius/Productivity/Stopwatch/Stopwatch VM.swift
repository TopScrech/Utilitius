import SwiftUI
import Combine

@Observable
final class StopwatchVM {
    var timeElapsed = 0.0
    var lastLapTime = 0.0
    var isRunning = false
    var cancellable: AnyCancellable?
    var lapTimes: [LapTime] = []
    
    func addLap() {
        let newLapTime = timeElapsed - lastLapTime
        let lap = LapTime(lapTimes.count + 1, time: newLapTime)
        
        withAnimation {
            lapTimes.append(lap)
            lastLapTime = timeElapsed
        }
    }
    
    func reset() {
        timeElapsed = 0.0
        resetLaps()
        lastLapTime = 0.0
    }
    
    func resetLaps() {
        withAnimation {
            lapTimes.removeAll()
        }
    }
    
    func start() {
        isRunning = true
        
        cancellable = Timer.publish(every: 0.01, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.timeElapsed += 0.01
            }
    }
    
    func stop() {
        isRunning = false
        cancellable?.cancel()
    }
    
//    func timeString(_ time: Double) -> String {
//        let formatter = DateComponentsFormatter()
//        formatter.allowedUnits = [.day, .hour, .minute, .second]
//        formatter.unitsStyle = .positional
//        formatter.zeroFormattingBehavior = .pad
//
//        let formattedTime = formatter.string(from: TimeInterval(time)) ?? ""
//        
//        return formattedTime
//    }
    
    func timeString(_ time: Double) -> String {
        let totalSeconds = Int(time)
        let days = totalSeconds / 86400
        let remainingSeconds = totalSeconds % 86400
        let hours = remainingSeconds / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = (remainingSeconds % 3600) % 60
        let milliseconds = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
        
        var timeString = ""
        
        if days > 0 {
            timeString += String(format: "%dd:", days)
        }
        
        if hours > 0 || !timeString.isEmpty {
            timeString += String(format: "%02d:", hours)
        }
        
        if minutes > 0 || !timeString.isEmpty {
            timeString += String(format: "%02d:", minutes)
        }
        
        timeString += String(format: "%02d,%02d", seconds, milliseconds)
        
        return timeString
    }
}
