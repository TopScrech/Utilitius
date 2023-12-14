import ScrechKit
import SwiftData

@main
struct UtilitiusApp: App {
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: InventoryItem.self,
                                           Tag.self,
                                           Note.self,
                                           Reminder.self,
                                           Countdown.self,
                                           Subscription.self,
                                           NFCMessage.self
            )
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
