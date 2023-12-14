import Foundation

struct XcodesResponse: Identifiable, Codable {
    var id: String {
        "\(name)\(version.number)\(version.build)\(links?.download?.url ?? "")"
    }
    
    let date: DateClass
    let links: Links?
    let name: String
    let requires: String
    let version: Version
    let checksums: Checksums?
    let compilers: Compilers?
    let sdks: Sdks?
}

struct Checksums: Codable {
    let sha1: String
}

struct Compilers: Codable {
    let gcc: [Clang]?
    let clang: [Clang]?
    let swift: [Clang]?
    let llvm: [Clang]?
    let llvm_gcc: [Clang]?
}

struct Clang: Codable {
    let build: String?
    let number: String?
    let release: ClangRelease
}

struct ClangRelease: Codable {
    let release: Bool
}

struct DateClass: Codable {
    let day, month, year: Int
    
    var date: Date? {
        var components = DateComponents()
        components.day = day
        components.month = month
        components.year = year
        
        return Calendar.current.date(from: components)
    }
}

struct Links: Codable {
    let download: Download?
    let notes: Download?
}

struct Download: Codable {
    let url: String
}

struct Sdks: Codable {
    let iOS: [Clang]?
    let macOS: [Clang]?
    let tvOS: [Clang]?
    let visionOS: [Clang]?
    let watchOS: [Clang]?
}

struct Version: Codable {
    let build: String
    let number: String
    let release: VersionRelease
}

struct VersionRelease: Codable {
    let beta: Int?
    let release: Bool?
    let rc: Int?
    let gm: Bool?
    let gmSeed, dp: Int?
}
