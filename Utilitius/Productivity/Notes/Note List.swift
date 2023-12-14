import ScrechKit
import SwiftData

struct NoteList: View {
    @Environment(NavState.self) private var navState
    @Environment(\.modelContext) private var modelContext
    @Environment(\.undoManager) private var undoManager
    @Query(animation: .default) private var notes: [Note]
    
    @State private var searchField = ""
    
    private var filteredNotes: [Note] {
        guard !searchField.isEmpty else {
            return notes
        }
        
        return notes.filter {
            $0.text.lowercased()
                .contains(searchField.lowercased())
        }
    }
    
    private var pinnedNotes: [Note] {
        filteredNotes.filter {
            $0.isPinned
        }
    }
    
    private var unpinnedNotes: [Note] {
        filteredNotes.filter {
            !$0.isPinned
        }
    }
    
    var body: some View {
        List {
            if notes.isEmpty {
                ContentUnavailableView("No Notes Found",
                                       systemImage: "note.text",
                                       description: Text("Create a new Note")
                )
            } else {
                if !pinnedNotes.isEmpty {
                    Section {
                        ForEach(pinnedNotes) { note in
                            NoteCard(note)
                                .contextMenu {
                                    MenuButton(note.isPinned ? "Unpin" : "Pin", icon: "pin") {
                                        note.isPinned.toggle()
                                    }
                                    
                                    Section {
                                        MenuButton("Delete", role: .destructive, icon: "trash") {
                                            modelContext.delete(note)
                                        }
                                    }
                                }
                        }
                        .onDelete(perform: deleteItems)
                    }
//                    } header: {
//                        Label("Pinned", systemImage: "bookmark")
//                    }
                    .searchable(text: $searchField)
                }
                
                Section {
                    ForEach(unpinnedNotes) { note in
                        NoteCard(note)
                            .contextMenu {
                                MenuButton(note.isPinned ? "Unpin" : "Pin", icon: "pin") {
                                    note.isPinned.toggle()
                                }
                                
                                Section {
                                    MenuButton("Delete", role: .destructive, icon: "trash") {
                                        modelContext.delete(note)
                                    }
                                }
                            }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
        }
        .navigationTitle("Notes")
        .overlay(alignment: .bottomTrailing) {
            ButtonCreate("square.and.pencil") {
                addItem()
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                if let manager = undoManager {
                    SFButton("arrow.uturn.backward") {
                        manager.undo()
                    }
                    .disabled(!manager.canUndo)
                    
                    SFButton("arrow.uturn.forward") {
                        manager.redo()
                    }
                    .disabled(!manager.canRedo)
                }
            }
#if os(iOS)
            ToolbarItem(placement: .navigationBarTrailing) {
//                EditButton()
            }
#endif
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
    NoteList()
        .environment(NavState())
        .modelContainer(for: Note.self, inMemory: true)
}
