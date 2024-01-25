import SwiftUI

struct NFCWriterView: View {
    @Environment(NFCWriterVM.self) private var writerModel
    
    private let message: String
    
    init(_ message: String = "") {
        self.message = message
    }
    
    @FocusState private var focus
    
    var body: some View {
        @Bindable var binding = writerModel
        
        VStack {
            HStack(alignment: .center) {
                //                Text(writerModel.prefix)
                //                    .foregroundStyle(.secondary)
                
                TextField("Enter your message here", text: $binding.textField)
                //                TextField(writerModel.placeholder, text: $binding.textField)
                    .focused($focus)
                    .title2()
                    .multilineTextAlignment(.center)
                    .padding(.top, 30)
            }
            .padding(.leading)
            
            //            Picker("Message Type", selection: $binding
            //                .selectedNfcMessageType) {
            //                ForEach(nfcMessageTypes, id: \.name) { type in
            //                    Text(type.name)
            //                        .tag(type.id)
            //                }
            //            }
            //            .pickerStyle(.inline)
            
            Spacer()
            
            Button {
                writerModel.writeTag()
            } label: {
                HStack {
                    Text("Write")
                        .title2(.semibold)
                        .semibold()
                    
                    Spacer()
                    
                    Image(systemName: "dot.radiowaves.right")
                        .largeTitle(.bold)
                        .symbolEffect(.variableColor.reversing.iterative)
                }
                .padding(.horizontal, 20)
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 70)
                .background(.blue, in: .rect(cornerRadius: 16))
            }
            .padding(.horizontal)
        }
        .task {
            writerModel.textField = message
            focus = true
        }
    }
}

#Preview {
    Text("Preview")
        .sheet {
            NFCWriterView()
                .environment(NFCWriterVM())
        }
}
