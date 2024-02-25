import SwiftUI

struct OTPCodeView: View {
    private let secretKey: String
    private var vm: TotpVM
    
    init(_ secretKey: String) {
        self.secretKey = secretKey
        self.vm = TotpVM(secretKey)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Your OTP is: ")
            
            HStack {
                ForEach(vm.code.split(separator: ""), id: \.self) { number in
                    Text(number)
                        .monospaced()
                        .largeTitle()
                        .frame(width: 35, height: 50)
                        .background(.ultraThinMaterial, in: .rect(cornerRadius: 8))
                }
            }
            .onTapGesture {
                UIPasteboard.general.string = vm.code
                Alert.copied()
            }
            
            Text("\(Int(vm.timeRemaining)) seconds left")
//            Text("\(String(format: "%.0", vm.timeRemaining)) seconds left")
                .monospaced()
                .animation(.default, value: vm.timeRemaining)
                .numericTransition()
        }
        .padding()
    }
}

#Preview {
    OTPCodeView("GXBPXPFQD7B34575JGY7CYZTKE7NTUWK")
}
