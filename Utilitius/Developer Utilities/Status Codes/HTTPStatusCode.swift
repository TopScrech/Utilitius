import Foundation

struct HTTPStatusCode {
    let code: UInt16
    let name: String
    let description: String
    
    init(
        _ code: UInt16,
        name: String,
        description: String = ""
    ) {
        self.code = code
        self.name = name
        self.description = description
    }
}
