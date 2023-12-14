import ScrechKit
import SwiftData

struct TimerList: View {
    @Environment(NavState.self) private var navState
    @Environment(\.modelContext) private var modelContext
    
    @Query(animation: .default)
    private var timers: [Countdown]
    
//    @Query(animation: .default)
//    private var tags: [Tag]
    
    var body: some View {
        List {
            if timers.isEmpty {
                ContentUnavailableView("No timers found",
                                       systemImage: "timer",
                                       description: Text("Create a new timer")
                )
            } else {
                ForEach(timers) { timer in
                    Button {
                        navState.navigate(.toEditor(timer))
                    } label: {
                        TimerCard(timer)
                    }
                    .swipeActions(edge: .leading, allowsFullSwipe: true) {
                        SFButton("bookmark") {
                            
                        }
                        .tint(.orange)
                        
                        SFButton("eye.slash") {
                            
                        }
                        .tint(.gray)
                    }
                    .contextMenu {
//                        Menu {
//                            ForEach(tags) { tag in
//                                Button {
//                                    if ((timer.tags?.contains(tag)) != nil) {
//                                        timer.tags?.remove(tag)
//                                    } else {
//                                        timer.tags?.append(tag)
//                                    }
//                                } label: {
//                                    if ((timer.tags?.contains(tag)) != nil) {
//                                        Label(tag.name, systemImage: "pin.slash")
//                                    } else {
//                                        Label(tag.name, systemImage: "pin")
//                                    }
//                                }
//                            }
//                        } label: {
//                            Label("Add a tag", systemImage: "pin")
//                        }
                        
                        Section {
                            MenuButton("Delete", role: .destructive, icon: "trash") {
                                modelContext.delete(timer)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteCountdown)
            }
        }
        .navigationTitle("Timers")
        .overlay(alignment: .bottomTrailing) {
            Button {
                modelContext.insert(
                    Countdown(
                        name: "New Countdown",
                        icon: "⏰",
                        note: "",
                        attachedUrl: nil
                    )
                )
            } label: {
                ButtonCreate()
            }
            //            TimerCreate()
        }
#if os(iOS)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
#endif
    }
    
    private func deleteCountdown(offsets: IndexSet) {
        for index in offsets {
            let countdown = timers[index]
            modelContext.delete(countdown)
        }
    }
}

#Preview {
    TimerList()
        .environment(NavState())
        .modelContainer(for: Countdown.self, inMemory: true)
}
