import SwiftData

@Model
final class Password {
    var name = ""
    var notes = ""
    var links: [String] = []
    @Attribute(.allowsCloudEncryption) var secret: String?
    @Attribute(.allowsCloudEncryption) var password: String?
    
    init(
        name: String = "",
        notes: String = "",
        links: [String] = [],
        secret: String? = nil,
        password: String? = nil
    ) {
        self.name = name
        self.notes = notes
        self.links = links
        self.secret = secret
        self.password = password
    }
}
