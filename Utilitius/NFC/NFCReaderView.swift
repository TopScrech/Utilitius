import SwiftUI

struct NFCReaderView: View {
    @Environment(NFCReaderModel.self) private var model
    
    @State private var showPayload = false
    
    var body: some View {
        VStack {
            if model.content.isEmpty {
                ContentUnavailableView("NFC tag has no content", systemImage: "airtag.radiowaves.forward", description: Text("Do something"))
            } else {
                Text(model.contentMessages.description)
                    .monospaced()
                    .minimumScaleFactor(0.5)
                    .scaledToFill()
                
                if showPayload {
                    Text(model.content)
                }
                
                Button("Show Payload") {
                    withAnimation {
                        showPayload.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    Text("Preview")
        .sheet {
            NFCReaderView()
                .environment(NFCReaderModel())
        }
}
