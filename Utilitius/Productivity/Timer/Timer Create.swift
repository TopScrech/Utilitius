//import SwiftUI
//
//struct TimerCreate: View {
//    @Environment(\.modelContext) private var modelContext
//    
//    var body: some View {
//        Menu {
//            Button("Now") {
//                createCountdown(Countdown(name: "New Countdown", icon: "⏰", note: "", attachedUrl: nil))
//            }
//            
//            Button("Tomorrow") {
//                createCountdown(Countdown(name: "New Countdown", icon: "⏰", note: "", attachedUrl: nil))
//            }
//            
//            //            Button("Custom") {
//            //                createCountdown(Countdown(deadline: Date()))
//            //            }
//        } label: {
//            ButtonCreate()
//        }
//    }
//    
//    private func createCountdown(_ item: Countdown) {
//        modelContext.insert(item)
//    }
//}
//
//#Preview {
//    TimerCreate()
//}
