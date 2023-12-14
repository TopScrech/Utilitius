import ScrechKit

struct AppList: View {
    @Environment(NavState.self) private var navState
    
    var body: some View {
        List {
            Section("Productivity") {
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
        AppList()
            .environment(NavState())
    }
}
