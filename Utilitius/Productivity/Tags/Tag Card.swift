import ScrechKit

struct TagCard: View {
    @Bindable private var tag: Tag
    
    init(_ tag: Tag) {
        self.tag = tag
    }
    
    var body: some View {
        TextField("New tag", text: $tag.name)
            .autocorrectionDisabled()
        
        //        if let countdowns = tag.countdowns, countdowns.count != 0 {
        //            DisclosureGroup {
        //                ForEach(countdowns) { countdown in
        //                    TimerCard(countdown)
        //                }
        //            } label: {
        //                HStack {
        //                    Image(systemName: "pin")
        //                        .bold()
        //                        .foregroundStyle(.red)
        //
        //                    TextField("Tag name", text: $tag.name)
        //
        //                    Spacer()
        //
        //                    Spacer().frame(width: 12)
        //                        .overlay(alignment: .trailing) {
        //                            Text(countdowns.count)
        //                                .foregroundStyle(.secondary)
        //                        }
        //                }
        //            }
        //        }
    }
}

#Preview {
    TagCard(previewTag)
}
