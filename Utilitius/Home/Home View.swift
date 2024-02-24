import SwiftUI

struct HomeView: View {
    @Environment(NavState.self) private var navState
    
    private var torch = TorchManager()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: [.init(.adaptive(minimum: 64))]) {
                Button {
                    navState.navigate(.toStopwatch)
                } label: {
                    AppListIcon("stopwatch")
                }
                
                Button {
                    navState.navigate(.toTimer)
                } label: {
                    AppListIcon("timer")
                }
                
                Button {
                    navState.navigate(.toVoiceMemos)
                } label: {
                    AppListIcon("mic")
                }
                
                Button {
                    navState.navigate(.toNotes)
                } label: {
                    AppListIcon("note.text")
                        .foregroundStyle(.yellow)
                }
                
                Button {
                    navState.navigate(.toReminder)
                } label: {
                    AppListIcon("checklist")
                        .foregroundStyle(.primary)
                }
                
                Button {
                    torch.toggleTorch()
                } label: {
                    AppListIcon(torch.isTorchOn ? "flashlight.on.fill" : "flashlight.off.fill")
                        .foregroundStyle(torch.isTorchOn ? .primary : .secondary)
                }
            }
            
            Spacer().frame(height: 32)
            
            //            ApplistSection("Test", icon: "hammer") {
            //                NavigationLink("Test") {
            //                    TONGameView()
            //                }
            //            }
            
            //#if DEBUG
            //                ApplistCard("Math", description: "-") {
            //                    navState.navigate(.toMath)
            //                }
            //#endif
            
            ApplistSection("Other", icon: "command") {
                ApplistCard("OTP", description: "-") {
                    navState.navigate(.toOTP)
                }
#if !DEBUG
                .disabled(true)
                .foregroundStyle(.secondary)
#endif
                ApplistCard("GOIDA24", description: "Hardware and software information utility") {
                    navState.navigate(.toGoida24)
                }
                
                ApplistCard("Multiboard", description: "-") {
                    navState.navigate(.toMultiboard)
                }
                
                ApplistCard("YouTube", description: "Download YouTube videos or extract high-quality audio") {
                    //                    YTDownloaderView()
                }
                .foregroundStyle(.secondary)
                .disabled(true)
                
                ApplistCard("NFC", description: "Read and write data to NFC-tags") {
                    navState.navigate(.toNFCScan)
                }
                
                ApplistCard("Morse", description: "Translator from Morse code and vice versa") {
                    navState.navigate(.toMorse)
                }
                
                ApplistCard("Inventory", description: "Record the amount of stock broken down by category") {
                    navState.navigate(.toInventory)
                }
            }
            
            ApplistSection("Development", icon: "hammer.fill") {
                ApplistCard("Xcodes", description: "All Xcode versions") {
                    navState.navigate(.toXcodes)
                }
                
                ApplistCard("Review Time", description: "App Store review time and more") {
                    navState.navigate(.toBuildTime)
                }
                
                ApplistCard("Frameworks", description: "-") {
                    navState.navigate(.toFrameworkList)
                }
                .foregroundStyle(.secondary)
                .disabled(true)
                
                ApplistCard("HTTP Status Codes", description: "All existing codes and their meaning") {
                    navState.navigate(.toHttpStatusCodes)
                }
            }
        }
        .padding(.horizontal)
        .foregroundStyle(.primary)
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
    .environment(NavState())
}
