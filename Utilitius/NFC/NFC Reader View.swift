import SwiftUI

struct NFCReaderView: View {
    @Environment(NFCReaderVM.self) private var vm
    
    @State private var showPayload = false
    
    var body: some View {
        NavigationView {
            if !vm.content.isEmpty {
                Text(vm.contentMessages.first?.description ?? "")
                    .monospaced()
                    .minimumScaleFactor(0.5)
                    .scaledToFill()
                
                if showPayload {
                    Text(vm.content)
                }
                
                Button("Show Payload") {
                    withAnimation {
                        showPayload.toggle()
                    }
                }
            }
        }
        .overlay {
            if vm.content.isEmpty {
                ContentUnavailableView("NFC tag has no content",
                                       systemImage: "airtag.radiowaves.forward",
                                       description: Text("Do something"))
            }
        }
    }
}

#Preview {
    Text("Preview")
        .sheet {
            NFCReaderView()
                .environment(NFCReaderVM())
        }
}
