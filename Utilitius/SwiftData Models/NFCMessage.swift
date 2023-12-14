import SwiftData

@Model
final class NFCMessage {
    var name = ""
    var prefix = ""
    var value = ""
    
    init(_ name: String, prefix: String, value: String) {
        self.name = name
        self.prefix = prefix
        self.value = value
    }
}
