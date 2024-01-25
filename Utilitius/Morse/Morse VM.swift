import SwiftUI
import CoreHaptics

@Observable
final class MorseVM: ObservableObject {
    var textField = ""
    
    var translatedText: String {
        translateToMorseOrSymbol(textField) ?? "Empty"
    }
    
    func copyToClipboard() {
        UIPasteboard.general.string = translatedText
    }
    
    func morseToHaptic(_ morseCode: String) {
        var hapticEngine: CHHapticEngine?
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("Haptic engine Creation/Error: \(error)")
            return
        }
        
        var hapticEvents: [CHHapticEvent] = []
        for char in morseCode {
            let duration: TimeInterval = char == "." ? 0.1 : char == "-" ? 0.3 : 0
            let hapticEvent = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 0, duration: duration)
            hapticEvents.append(hapticEvent)
        }
        
        do {
            let pattern = try CHHapticPattern(events: hapticEvents, parameters: [])
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to play pattern: \(error)")
        }
    }
    
    func translateToMorseOrSymbol(_ input: String) -> String? {
        let isMorse = input.starts(with: ".") || input.starts(with: "-")
        return isMorse ? decodeMorse(input) : encodeToMorse(input)
    }
    
    private func decodeMorse(_ morseCode: String) -> String? {
        morseCode.split(separator: " ").compactMap { code in
            MorseCodeMapping.morseToChar[String(code)]
        }.joined()
    }
    
    private func encodeToMorse(_ text: String) -> String? {
        text.uppercased().compactMap { char in
            MorseCodeMapping.charToMorse[char]
        }.joined(separator: " ")
    }
}

struct MorseCodeMapping {
    static let morseToChar: [String: String] = {
        var mapping = [String: String]()
        for alphabet in MorseEnglishAlphabet.allCases {
            mapping[alphabet.morseCode] = alphabet.rawValue
        }
        for alphabet in MerseRussianAlphabet.allCases {
            mapping[alphabet.morseCode] = alphabet.rawValue
        }
        for number in MorseArabicNumbers.allCases {
            mapping[number.morseCode] = number.rawValue
        }
        for special in MorseSpecialCharacters.allCases {
            mapping[special.morseCode] = special.rawValue
        }
        return mapping
    }()
    
    static let charToMorse: [Character: String] = {
        var mapping = [Character: String]()
        for alphabet in MorseEnglishAlphabet.allCases {
            mapping[Character(alphabet.rawValue)] = alphabet.morseCode
        }
        for alphabet in MerseRussianAlphabet.allCases {
            mapping[Character(alphabet.rawValue)] = alphabet.morseCode
        }
        for number in MorseArabicNumbers.allCases {
            mapping[Character(number.rawValue)] = number.morseCode
        }
        for special in MorseSpecialCharacters.allCases {
            mapping[Character(special.rawValue)] = special.morseCode
        }
        return mapping
    }()
}
