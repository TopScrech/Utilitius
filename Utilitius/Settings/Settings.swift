import ScrechKit
import SwiftData

struct Settings: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var tags: [Tag]
    @Query private var notes: [Note]
    @Query private var countdowns: [Countdown]
    
    var body: some View {
        List {
            Menu {
                Button("Delete all tags", role: .destructive) {
                    delete(tags)
                }
                
                Button("Delete all notes", role: .destructive) {
                    delete(notes)
                }
                
                Button("Delete all timers", role: .destructive) {
                    delete(countdowns)
                }
                
                Divider()
                
                Button(role: .destructive) {
                    deleteAll()
                } label: {
                    Label("Delete everything", systemImage: "trash")
                }
            } label: {
                Text("Remove data")
                    .foregroundStyle(.red)
            }
        }
        .navigationTitle("Settings")
        .toolbarTitleDisplayMode(.inline)
    }
    
    private func deleteAll() {
        delete(tags)
        delete(notes)
        delete(countdowns)
    }
    
    private func delete (_ items: [any PersistentModel]) {
        for item in items {
            modelContext.delete(item)
        }
    }
}

#Preview {
    Settings()
}
