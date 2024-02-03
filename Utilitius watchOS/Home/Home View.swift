import ScrechKit

struct HomeView: View {
    @Environment(NavState.self) private var navState
    
    var body: some View {
        List {
            Section("Productivity") {
                MenuButton("Notes", icon: "note.text") {
                    navState.navigate(.toNotes)
                }
                
                MenuButton("Reminders", icon: "checklist") {
                    navState.navigate(.toReminder)
                }
                
                MenuButton("Stopwatch", icon: "stopwatch") {
                    navState.navigate(.toStopwatch)
                }
            }
            
            Section {
                MenuButton("HTTP Codes", icon: "hammer") {
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
