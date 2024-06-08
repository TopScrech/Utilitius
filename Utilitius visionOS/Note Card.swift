import SwiftUI

struct NoteCard: View {
    @Bindable private var note: Note
    
    init(_ note: Note) {
        self.note = note
    }
    
    var body: some View {
        HStack {
            VStack {
                Text(note.title)
                
                Text(note.text)
                    .lineLimit(1)
                    .footnote()
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
//            Image(systemName: "")
        }
    }
}

#Preview {
    NoteCard(.init(title: "Preview", text: "Preview"))
}
