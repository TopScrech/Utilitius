import Foundation

struct Framework {
    let name, description, docUrl: String
    let idDeprecated: Bool
    
    init(
        name: String,
        description: String = "N/a",
        docUrl: String = "",
        isDeprecated: Bool = false
    ) {
        self.name = name
        self.description = description
        self.docUrl = docUrl
        self.idDeprecated = isDeprecated
    }
}

@Observable
final class FrameworkModel {
    let frameworks: [Framework] = [
        .init(name: "Accelerate", description: "Make large-scale mathematical computations and image calculations, optimized for high performance and low energy consumption.", docUrl: "https://developer.apple.com/documentation/accelerate"),
        .init(name: "Accessibility", description: "Make your apps accessible to everyone who uses Apple devices.", docUrl: "https://developer.apple.com/documentation/accessibility"),
        .init(name: "Contacts"),
        .init(name: "Foundation"),
        .init(name: "SwiftUI"),
        .init(name: "UIKit"),
        .init(name: "ActivityKit"),
        .init(name: "Combine"),
        .init(name: "OSLog"),
        
        // MARK: - Deprecated
        .init(name: "Address Book UI", isDeprecated: true),
        .init(name: "Accounts", isDeprecated: true),
    ]
}
