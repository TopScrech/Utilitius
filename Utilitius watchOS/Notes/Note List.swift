import SwiftUI
import SwiftData

struct NoteList: View {
    @Environment(\.modelContext) private var modelContext
    @Query(animation: .default) private var notes: [Note]
    
    var body: some View {
        List {
            ForEach(notes) { note in
                NoteCard(note)
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    addItem()
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                }
            }
        }
    }
    
    private func addItem() {
        let newItem = Note()
        modelContext.insert(newItem)
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(notes[index])
        }
    }
}

#Preview {
    NavigationView {
        NoteList()
    }
    .modelContainer(for: Note.self)
}
