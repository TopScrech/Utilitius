import ScrechKit

extension String {
    func onlyEmoji() -> String {
        self.filter {
            $0.isEmoji
        }
    }
}

extension Character {
    var isEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        
        return scalar.properties.isEmoji && (scalar.value > 0x238C || unicodeScalars.count > 1)
    }
}
