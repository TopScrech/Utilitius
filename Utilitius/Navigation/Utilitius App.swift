import ScrechKit
import SwiftData

@main
struct UtilitiusApp: App {
    private let container: ModelContainer
    
    init() {
        let schema = Schema([
            MultiboardItem.self,
            InventoryItem.self,
            Tag.self,
            Note.self,
            Reminder.self,
            Countdown.self,
            Subscription.self,
            NFCMessage.self
        ])
        
        do {
            container = try ModelContainer(for: schema)
        } catch {
            fatalError("Failed to create model container")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            AppContainer()
        }
        .modelContainer(container)
    }
}
