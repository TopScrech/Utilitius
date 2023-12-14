import Foundation

struct AudioFile: Identifiable {
    let id = UUID()
    let name: String
    let creationDate: Date?
    let length: TimeInterval?
    let size: Int64?
}
