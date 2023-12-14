import SwiftUI

struct AppList: View {
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
            
            //            AppList_Section("Test", icon: "hammer") {
            //                NavigationLink("Test") {
            //                    TONGameView()
            //                }
            //            }
            
            //#if DEBUG
            //                AppList_Card("Math", description: "-") {
            //                    navState.navigate(.toMath)
            //                }
            //#endif
            
            AppList_Section("Other", icon: "command") {
                AppList_Card("OTP", description: "-") {
                    navState.navigate(.toOTP)
                }
#if !DEBUG
                .disabled(true)
                .foregroundStyle(.secondary)
#endif
                AppList_Card("GOIDA24", description: "Hardware and software information utility") {
                    navState.navigate(.toGoida24)
                }
                
                AppList_Card("YouTube", description: "Download YouTube videos or extract high-quality audio") {
                    //                    YTDownloaderView()
                }
                .foregroundStyle(.secondary)
                .disabled(true)
                
                AppList_Card("NFC", description: "Read and write data to NFC-tags") {
                    navState.navigate(.toNFCScan)
                }
                
                AppList_Card("Morse", description: "Translator from Morse code and vice versa") {
                    navState.navigate(.toMorse)
                }
                
                AppList_Card("Inventory", description: "Record the amount of stock broken down by category") {
                    navState.navigate(.toInventory)
                }
            }
            
            AppList_Section("Development", icon: "hammer.fill") {
                AppList_Card("Xcodes", description: "All Xcode versions") {
                    navState.navigate(.toXcodes)
                }
                
                AppList_Card("Review Time", description: "App Store review time and more") {
                    navState.navigate(.toBuildTime)
                }
                
                AppList_Card("Frameworks", description: "-") {
                    navState.navigate(.toFrameworkList)
                }
                .foregroundStyle(.secondary)
                .disabled(true)
                
                AppList_Card("HTTP Status Codes", description: "All existing codes and their meaning") {
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
        AppList()
    }
    .environment(NavState())
}
