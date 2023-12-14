import Foundation
import CryptoKit
import SwiftOTP

@Observable
final class OTPModel {
    let period: TimeInterval = 30
    let digits = 6
    let secret: Data
    var counter: UInt64
    var otp = ""
    
    init(_ secret: String) {
        self.secret = secret.data(using: .utf8)!
//        self.secret = Data(base64Encoded: secret)!
        counter = UInt64(Date().timeIntervalSince1970 / period).bigEndian
    }
    
    func generateOTP() {
        if let code = TOTP(secret: secret, algorithm: .sha1)?.generate(time: Date(timeInterval: TimeInterval(30), since: .now)) {
            otp = code
        }
    }
//    func generateOTP() {
//        var bigEndianCounter = counter.bigEndian
//        let counterData = withUnsafeBytes(of: &bigEndianCounter) { Array($0) }
//        
//        let hash = HMAC<SHA512>.authenticationCode(for: counterData, using: SymmetricKey(data: secret))
//        let hashData = Data(hash)
//        
//        let offset = Int(hashData[hashData.count - 1] & 0x0F)
//        let truncatedHash = hashData.subdata(in: offset..<offset+4).withUnsafeBytes { $0.load(as: UInt32.self) } & 0x7FFFFFFF
//        
//        let otpValue = truncatedHash % UInt32(pow(10, Float(digits)))
//        otp = String(format: "%0*u", digits, otpValue)
//    }
}

//@Observable
//final class OTPModel {
//    private let secretKeyData: Data
//    private var timer: Timer?
//    private let expirationInterval: TimeInterval = 30
//
//    init(_ secretKey: String) {
//        guard let secretKeyData = secretKey.data(using: .utf8) else {
//            fatalError("Invalid secret key")
//        }
//        self.secretKeyData = secretKeyData
//        self.otp = generateTOTP()
//        startTimer()
//    }
//
//    var otp = ""
//    var timeLeft = 30
//
//    func generateTOTP() -> String {
//        let interval = Date().timeIntervalSince1970
//        let counter = UInt64(interval / expirationInterval)
//        timeLeft = Int(expirationInterval) - Int(interval.truncatingRemainder(dividingBy: expirationInterval))
//
//        return generateOTP(counter: counter)
//    }
//
//    private func generateOTP(counter: UInt64) -> String {
//        var bigEndianCounter = counter.bigEndian
//        let counterData = Data(bytes: &bigEndianCounter, count: MemoryLayout.size(ofValue: bigEndianCounter))
//        let hmac = HMAC<SHA256>.authenticationCode(for: counterData, using: SymmetricKey(data: secretKeyData))
//        let otpValue = truncate(hmac: Data(hmac))
//
//        return String(format: "%06d", otpValue)
//    }
//
//    private func truncate(hmac: Data) -> Int {
//        let offset = Int(hmac[hmac.count - 1] & 0x0F)
//        let truncatedHMAC = hmac.subdata(in: offset..<offset + 4)
//        var number = truncatedHMAC.withUnsafeBytes { $0.load(as: UInt32.self) }
//        number = number.bigEndian
//
//        return Int(number) & 0x7FFFFFFF % 1_000_000 // 6 digits
//    }
//
//    private func startTimer() {
//        timer?.invalidate()
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
//            guard let self = self else { return }
//            if self.timeLeft > 0 {
//                self.timeLeft -= 1
//            } else {
//                self.otp = self.generateTOTP()
//            }
//        }
//    }
//
//    deinit {
//        timer?.invalidate()
//    }
//}
