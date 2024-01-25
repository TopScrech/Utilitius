import SwiftUI

struct MorseView: View {
    @Bindable private var vm = MorseVM()
    
    //    @AppStorage("chosenSeparator") private var chosenSeparator: MorseModel.MorseSeparators = .space
    
    var body: some View {
        VStack {
            TextField("Type Morse code or regular text here", text: $vm.textField)
                .multilineTextAlignment(.center)
                .autocorrectionDisabled()
                .padding(.bottom)
            
            VStack(spacing: 0) {
                HStack(spacing: 50) {
                    Button {
                        vm.copyToClipboard()
                    } label: {
                        Text("Copy")
                        Image(systemName: "doc.on.doc")
                    }
                    
                    Button {
                        vm.textField = ""
                    } label: {
                        Text("Clear")
                        Image(systemName: "trash")
                    }
                    .foregroundStyle(.red)
                    
                    Button {
                        if let string = UIPasteboard.general.string {
                            vm.textField = string
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
                    Text(vm.translatedText)
                        .animation(.default, value: vm.translatedText)
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
