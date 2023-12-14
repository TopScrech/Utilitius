import ScrechKit
import SwiftData

struct TagList: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(animation: .default)
    private var tags: [Tag]
    
    //    @Query(sort: \.deadline, order: .reverse, animation: .default)
    @Query(animation: .default)
    private var countdowns: [Countdown]
    
    var body: some View {
        List {
            if tags.isEmpty {
                ContentUnavailableView("No Tags Found",
                                       systemImage: "tag",
                                       description: Text("Create a new Tag")
                )
            } else {
                ForEach(tags) { tag in
                    TagCard(tag)
                }
                .onDelete(perform: deleteTags)
            }
        }
        .navigationTitle("Tags")
        .overlay(alignment: .bottomTrailing) {
            ButtonCreate {
                createTag(Tag("New Tag"))
            }
        }
    }
    
    private func createTag(_ newItem: Tag) {
        modelContext.insert(newItem)
    }
    
    private func deleteTags(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(tags[index])
        }
    }
}

#Preview {
    TagList()
}
