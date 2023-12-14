import SwiftUI

enum ProductivityTabs: String {
    case notes,
         reminders,
         timers,
         stopwatch,
         tags
}

struct ProductivityEnvironment: View {
    @AppStorage("lastProductivityTab") private var lastProductivityTab: ProductivityTabs = .notes
    
    var body: some View {
        TabView(selection: $lastProductivityTab) {
            NavigationView {
                NoteList()
            }
            .tag(ProductivityTabs.notes)
            .tabItem {
                Label("Notes", systemImage: "note.text")
            }
            
            NavigationView {
                ReminderParent()
            }
            .tag(ProductivityTabs.reminders)
            .tabItem {
                Label("Reminders", systemImage: "checklist")
            }
            
            NavigationView {
                TimerList()
            }
            .tag(ProductivityTabs.timers)
            .tabItem {
                Label("Timers", systemImage: "timer")
            }
            
            NavigationView {
                StopwatchView()
            }
            .tag(ProductivityTabs.stopwatch)
            .tabItem {
                Label("Stopwatch", systemImage: "stopwatch")
            }
            
            NavigationView {
                TagList()
            }
            .tag(ProductivityTabs.tags)
            .tabItem {
                Label("Tags", systemImage: "tag")
            }
        }
    }
}

#Preview {
    ProductivityEnvironment()
}
