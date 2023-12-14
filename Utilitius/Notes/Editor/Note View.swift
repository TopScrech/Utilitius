import ScrechKit

struct NoteView: View {
    @Bindable private var note: Note
    
    init(_ note: Note) {
        self.note = note
    }
    
    @AppStorage("showAssets") private var showAssets = false
    @AppStorage("showDates") private var showDates = true
    
    var body: some View {
        VStack {
            if showDates {
                VStack {
                    Text("Created: \(note.created, format: Date.FormatStyle(date: .abbreviated, time: .shortened))")
                    
                    if let modified = note.modified {
                        Text("Modified: \(modified, format: Date.FormatStyle(date: .abbreviated, time: .shortened))")
                    }
                }
                .foregroundStyle(.secondary)
                .footnote()
                .swipeToHide($showDates)
            }
            
            if showAssets {
                NoteAssets(note)
                    .swipeToHide($showAssets)
            }
#if os(iOS)
            TextEditor(text: $note.text)
                .padding(.horizontal)
#endif
        }
        .toolbar {
            Menu {
                MenuButton(showAssets ? "Hide assets" : "Show assets", icon: "photo.stack") {
                    withAnimation {
                        showAssets.toggle()
                    }
                }
                
                MenuButton(showDates ? "Hide dates" : "Show details", icon: "calendar.badge.clock") {
                    withAnimation {
                        showDates.toggle()
                    }
                }
            } label: {
                Image(systemName: "ellipsis.circle")
            }
        }
        .onChange(of: note.text) {
            withAnimation {
                note.modified = Date()
            }
        }
    }
}

#Preview {
    NoteView(previewNote)
}
