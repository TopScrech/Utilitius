import ScrechKit

struct NoteCard: View {
    @Environment(NavState.self) private var navState
    @Bindable private var note: Note
    
    init(_ note: Note) {
        self.note = note
    }
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        Button {
            navState.navigate(.toNote(note))
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    if let firstNonEmptyLine = note.text.split(separator: "\n")
                        .first(where: {
                            !$0.trimmingCharacters(in: .whitespaces).isEmpty
                        })
                    {
                        Text(firstNonEmptyLine)
                            .lineLimit(1)
                    }
                    
                    Group {
                        if let modified = note.modified {
                            Text(modified, format: .dateTime)
                        } else {
                            Text(note.created, format: .dateTime)
                        }
                    }
                    .footnote()
                    .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                if note.isPinned {
                    Image(systemName: "pin")
                        .title2(.bold)
                        .foregroundStyle(.red)
                }
            }
            .padding(.vertical, 2)
            .foregroundStyle(.foreground)
            .renameAction {
                isFocused = true
            }
#if !os(tvOS)
            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                Button_Pin(note)
            }
#endif
        }
    }
}

#Preview {
    NoteCard(previewNote)
        .environment(NavState())
}
