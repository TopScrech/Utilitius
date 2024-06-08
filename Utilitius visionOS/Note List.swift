import SwiftUI
import SwiftData

struct NoteList: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.undoManager) private var undoManager
    @Query(animation: .default) private var notes: [Note]
    
    var body: some View {
        List {
            ForEach(notes) { note in
                NoteCard(note)
            }
        }
    }
}

#Preview {
    NoteList()
}
