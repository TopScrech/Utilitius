import SwiftUI

struct OtpView: View {
    private let secretKey: String
    private var vm: TotpVM
    
    init(_ secretKey: String) {
        self.secretKey = secretKey
        self.vm = TotpVM(secretKey)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("\(Int(vm.timeRemaining)) seconds left")
                .monospaced()
                .animation(.default, value: vm.timeRemaining)
                .numericTransition()
            
            HStack {
                ForEach(vm.code.split(separator: ""), id: \.self) { number in
                    Text(number)
                        .monospaced()
                        .largeTitle()
                        .numericTransition()
                        .frame(width: 35, height: 50)
                        .background(.ultraThinMaterial, in: .rect(cornerRadius: 8))
                }
            }
            .onTapGesture {
                UIPasteboard.general.string = vm.code
                Alert.copied()
            }
            
            Spacer()
            
            HStack {
                Button {
                    
                } label: {
                    Text("Copy")
                        .padding()
                        .title2(.semibold)
                        .background(.ultraThinMaterial, in: .rect(cornerRadius: 16))
                }
                
                ShareLink(item: vm.code) {
                    Image(systemName: "square.and.arrow.up")
                        .padding()
                        .title(.semibold)
                        .foregroundStyle(.white)
                        .background(.blue, in: .rect(cornerRadius: 16))
                }
            }
        }
    }
}

#Preview {
    OtpView("DRIG5PU6CTAH2MYENGIVF542GZ72PFVJ")
}
