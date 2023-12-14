import OSLog

extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    /// Logs the view cycles like a view that appeared.
    static let networkCalls = Logger(subsystem: subsystem, category: "Network Calls")
}
