import SwiftData

@Model
final class Subscription {
    var name = ""
    var repeatPeriod = RepeatPeriod.monthly
    
    init(_ name: String = "", repeatPeriod: RepeatPeriod = .monthly) {
        self.name = name
        self.repeatPeriod = repeatPeriod
    }
}

enum RepeatPeriod: String, Codable {
    case daily = "Dayly"
    case monthly = "Monthly"
    case quarterly = "Quarterly"
    case yearly = "Yearly"
}
