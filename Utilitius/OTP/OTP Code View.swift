import SwiftUI

struct OTPCodeView: View {
    private let secretKey: String
    private var vm: OTPVM
    
    init(_ secretKey: String) {
        self.secretKey = secretKey
        self.vm = OTPVM(secretKey)
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Your OTP is: ")
            
            HStack {
                ForEach(vm.otp.split(separator: ""), id: \.self) { number in
                    Text(number)
                        .monospaced()
                        .largeTitle()
                        .frame(width: 35, height: 50)
                        .background(.ultraThinMaterial, in: .rect(cornerRadius: 8))
                }
            }
            .onTapGesture {
                UIPasteboard.general.string = vm.otp
                Alert.copied()
            }
            //            Text("\(model.timeLeft) seconds left")
            //                .monospaced()
            //                .animation(.default, value: model.timeLeft)
            //                .numericTransition()
        }
        .padding()
        .task {
            vm.generateOTP()
        }
    }
}

#Preview {
    OTPCodeView("GXBPXPFQD7B34575JGY7CYZTKE7NTUWK")
}
