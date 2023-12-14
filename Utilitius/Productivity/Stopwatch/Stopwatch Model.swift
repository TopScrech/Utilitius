import Foundation

struct LapTime {
    let id = UUID()
    let index: Int
    let time: Double
    
    init(_ index: Int, time: Double) {
        self.index = index
        self.time = time
    }
}
