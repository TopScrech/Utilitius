import ScrechKit

struct Button_Pin: View {
    @Bindable private var note: Note
    
    init(_ note: Note) {
        self.note = note
    }
    
    var body: some View {
        Button {
            note.isPinned.toggle()
        } label : {
            Image(systemName: note.isPinned ? "bookmark.slash" : "bookmark")
        }
        .tint(.orange)
    }
}

//#Preview {
//    Button_Pin(previewNote)
//}
