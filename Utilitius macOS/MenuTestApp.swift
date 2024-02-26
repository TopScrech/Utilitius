import ScrechKit
import SwiftData

//import Cocoa
import ServiceManagement

//extension Notification.Name {
//    static let killLauncher = Notification.Name("killLauncher")
//}

//@NSApplicationMain
//class AppDelegate: NSObject {}


//extension AppDelegate: NSApplicationDelegate {
//    func applicationDidFinishLaunching(_ aNotification: Notification) {
//        
//        let launcherAppId = "com.tiborbodecs.LauncherApplication"
//        let runningApps = NSWorkspace.shared.runningApplications
//        
//        let isRunning = !runningApps.filter {
//            $0.bundleIdentifier == launcherAppId
//        }.isEmpty
//        
//        SMLoginItemSetEnabled(launcherAppId as CFString, true)
//        
//        if isRunning {
//            DistributedNotificationCenter.default().post(
//                name: .killLauncher,
//                object: Bundle.main.bundleIdentifier!
//            )
//        }
//    }
//}

@main
struct MyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    private var pasteboardObserver = PasteboardVM()
    
    private let container: ModelContainer
    
    init() {
        let schema = Schema([
            PasteboardItem.self
            //            MultiboardItem.self,
            //            InventoryItem.self,
            //            Tag.self,
            //            Note.self,
            //            Reminder.self,
            //            Countdown.self,
            //            Subscription.self,
            //            NFCMessage.self,
            //            Password.self
        ])
        
        do {
            container = try ModelContainer(for: schema)
        } catch {
            fatalError("Failed to create model container")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            PasteboardList()
                .modelContainer(container)
                .environment(pasteboardObserver)
        }
        
        MenuBarExtra("Test", systemImage: "hammer") {
            MenuBarExtraView()
                .modelContainer(container)
                .environment(pasteboardObserver)
        }
        .menuBarExtraStyle(.window)
    }
}
