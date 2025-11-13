import SwiftUI

struct HomeView: View {
    @Environment(NavState.self) private var navState
    
    var body: some View {
        List {
            Section("Productivity") {
                Button("Notes", systemImage: "note.text") {
                    navState.navigate(.toNotes)
                }
                
                Button("Reminders", systemImage: "checklist") {
                    navState.navigate(.toReminder)
                }
                
                Button("Stopwatch", systemImage: "stopwatch") {
                    navState.navigate(.toStopwatch)
                }
            }
            
            Section {
                Button("HTTP Codes", systemImage: "hammer") {
                    navState.navigate(.toHttpStatusCodes)
                }
            }
        }
        .navigationTitle("Utilitius")
    }
}

#Preview {
    NavigationView {
        HomeView()
            .environment(NavState())
    }
}
