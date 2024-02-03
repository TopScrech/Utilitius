import ScrechKit

struct HomeView: View {
    @Environment(NavState.self) private var navState
    
    var body: some View {
        List {
            Section("Productivity") {
                MenuButton("Notes", icon: "note.text") {
                    navState.navigate(.toNotes)
                }
                
                MenuButton("Stopwatch", icon: "stopwatch") {
                    navState.navigate(.toStopwatch)
                }
                
                MenuButton("Reminder", icon: "checklist") {
                    navState.navigate(.toReminder)
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
