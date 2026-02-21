import Foundation
import SwiftOTP

@Observable
final class TotpVM {
    let secret: String
    
    var otpTimer: Foundation.Timer?
    var secondTimer: Foundation.Timer?
    var code = ""
    
    var timeRemaining = 30.0
    
    init(_ secret: String) {
        self.secret = secret
        startTimer()
        startSecondTimer()
        generate()
    }
    
    deinit {
        stopTimer()
    }
    
    private func startSecondTimer() {
        secondTimer = Foundation.Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.timeRemaining = self?.calculateTimeRemaining() ?? 30
        }
        
        if let timer = secondTimer {
            RunLoop.current.add(timer, forMode: .common)
            timer.fire()
        }
    }
    
    func generate() {
        if let data = base32DecodeToData(secret),
           let totp = TOTP(secret: data) {
            let otpString = totp.generate(time: Date())
            if otpString != nil {
                DispatchQueue.main.async {
                    self.code = otpString ?? "Error"
                }
            } else {
                print("Error generating OTP")
            }
        } else {
            print("Error decoding secret")
        }
    }
    
    private func calculateTimeRemaining() -> Double {
        let interval = 30.0
        let timeSinceEpoch = Date().timeIntervalSince1970
        return interval - fmod(timeSinceEpoch, interval)
    }
    
    private func startTimer() {
        let timeToNextInterval = timeRemaining
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeToNextInterval) {
            self.otpTimer = Foundation.Timer.scheduledTimer(
                timeInterval: 30,
                target: self,
                selector: #selector(self.updateOTP),
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    private func stopTimer() {
        otpTimer?.invalidate()
        otpTimer = nil
    }
    
    @objc private func updateOTP() {
        generate()
    }
}
