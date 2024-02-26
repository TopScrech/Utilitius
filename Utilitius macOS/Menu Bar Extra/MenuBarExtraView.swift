import SwiftUI
import SwiftData

struct MenuBarExtraView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [PasteboardItem]
    
    @Environment(PasteboardVM.self) private var pasteboardObserver
    
    @State private var showTime = false
    @State private var animate = false
    
    var body: some View {
        VStack {
            List(items.reversed()) { item in
                Button {
                    NSPasteboard.general.clearContents()
                    NSPasteboard.general.setString(item.content, forType: .string)
                } label: {
                    Text(item.content)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    if showTime {
                        if animate || !animate {
                            Text(item.date, style: .time)
                                .footnote()
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .buttonStyle(.accessoryBar)
            }
            .scrollIndicators(.never)
            
            Toggle("Show time", isOn: $showTime)
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .buttonStyle(.plain)
            .padding(.bottom)
        }
        .onChange(of: showTime) { _, _ in
            withAnimation {
                animate.toggle()
            }
        }
    }
}

#Preview {
    MenuBarExtraView()
}
