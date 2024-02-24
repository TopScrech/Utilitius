import SwiftUI

@main
struct visionOSApp: App {
    var body: some Scene {
        WindowGroup {
            ViewContainer()
        }
        
        WindowGroup(id: "test") {
            Text("Test")
        }
    }
}
