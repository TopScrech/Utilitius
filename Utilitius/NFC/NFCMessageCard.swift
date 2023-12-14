import SwiftUI
import SafariCover

struct NFCMessageCard: View {
    @Bindable private var message: NFCMessage
    @Bindable var writerModel = NFCWriterModel()
    
    init(_ message: NFCMessage) {
        self.message = message
    }
    
    @State private var alertRename = false
    @State private var sheetSafari = false
    @State private var newName = ""
    @State private var newValue = ""
    @State private var sheetTagWriter = false
    
    var body: some View {
        Button {
            sheetTagWriter = true
        } label: {
            HStack {
                VStack(alignment: .leading) {
                    Text(message.name)
                    
                    HStack(spacing: 0) {
                        Text(message.prefix)
                            .foregroundStyle(.secondary)
                        
                        Text(message.value)
                    }
                    .footnote()
                }
                .foregroundStyle(.foreground)
                
                Spacer()
                
                Image(systemName: "dot.radiowaves.forward")
                    .foregroundStyle(.blue)
                    .title()
            }
        }
        .contextMenu {
            Button {
                alertRename = true
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            
            Button {
                sheetSafari = true
            } label: {
                Label("Open", systemImage: "safari")
            }
            
            Button {
                sheetTagWriter = true
            } label: {
                Label("Write", systemImage: "dot.radiowaves.forward")
            }
        }
        .safariCover($sheetSafari, url: message.prefix + message.value)
        .sheet($sheetTagWriter) {
            NFCWriterView(message.prefix + message.value)
                .environment(writerModel)
        }
        .alert("Rename", isPresented: $alertRename) {
            TextField("New name", text: $newName)
            
            TextField("Content", text: $newValue)
            
            Button("Cancel", role: .cancel) {}
            
            Button("Rename", role: .destructive) {
                message.name = newName
                message.value = newValue
            }
        }
    }
}

#Preview {
    List {
        NFCMessageCard(
            NFCMessage(
                "Preview",
                prefix: "https://",
                value: "bisquit.host")
        )
    }
    .modelContainer(for: NFCMessage.self, inMemory: true)
}
