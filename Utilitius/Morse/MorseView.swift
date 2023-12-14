import SwiftUI

struct MorseView: View {
    @Bindable private var model = MorseModel()
    
    //    @AppStorage("chosenSeparator") private var chosenSeparator: MorseModel.MorseSeparators = .space
    
    var body: some View {
        VStack {
            TextField("Type Morse code or regular text here", text: $model.textField)
                .multilineTextAlignment(.center)
                .autocorrectionDisabled()
                .padding(.bottom)
            
            VStack(spacing: 0) {
                HStack(spacing: 50) {
                    Button {
                        model.copyToClipboard()
                    } label: {
                        Text("Copy")
                        Image(systemName: "doc.on.doc")
                    }
                    
                    Button {
                        model.textField = ""
                    } label: {
                        Text("Clear")
                        Image(systemName: "trash")
                    }
                    .foregroundStyle(.red)
                    
                    Button {
                        if let string = UIPasteboard.general.string {
                            model.textField = string
                        }
                    } label: {
                        Text("Paste")
                        Image(systemName: "doc.on.clipboard")
                    }
                }
                .foregroundStyle(.foreground)
                .padding()
                
                Divider()
                
                ScrollView {
                    Text(model.translatedText)
                        .animation(.default, value: model.translatedText)
                        .multilineTextAlignment(.leading)
                        .monospaced()
                        .padding()
                }
                .padding(.bottom)
            }
            .frame(minWidth: 50, maxWidth: .infinity)
            .frame(minHeight: 100)
            .background(.ultraThinMaterial, in: .rect(cornerRadius: 16))
        }
        .padding(.horizontal)
    }
}

#Preview {
    MorseView()
}
