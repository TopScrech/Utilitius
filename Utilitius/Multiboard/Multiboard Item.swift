import Foundation
import SwiftData

@Model
final class MultiboardItem {
    var name: String = ""
    var content: String = ""
    var createdAt: Date?
    var modifiedAt: Date?
    
    init(_ name: String, content: String, createdAt: Date) {
        self.name = name
        self.content = content
        self.createdAt = createdAt
    }
}
