import SwiftUI

struct NoteCard: View {
    @Bindable private var note: Note
    
    init(_ note: Note) {
        self.note = note
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(note.title)
            
            Text(note.text)
                .lineLimit(1)
                .footnote()
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    List {
        NoteCard(.init(title: "Preview", text: "Preview text"))
    }
}
