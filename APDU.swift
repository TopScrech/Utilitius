import Foundation

enum ApduType {
    case aarqApdu, aareApdu, abrtApdu, prstApdu, rlreApdu, rlrqApdu, unknown
    
    // A function to initialize APDU type from a given raw value, byte, or identifier
    static func from(rawValue: UInt8) -> ApduType {
        switch rawValue {
        case 0x00: return .aarqApdu
        case 0x01: return .aareApdu
        case 0x02: return .abrtApdu
        case 0x03: return .prstApdu
        case 0x04: return .rlreApdu
        case 0x05: return .rlrqApdu
        default: return .unknown
        }
    }
}

struct ApduMessage {
    let type: ApduType
    // Example of other fields you might expect in an APDU message
    let invokeId: Int
    let data: Data
    
    init?(payload: Data) {
        // Ensure payload is not empty and has a minimum expected length
        guard !payload.isEmpty else { return nil }
        
        // Example of parsing the payload, starting with the APDU type
        // This assumes the first byte indicates the APDU type
        let typeByte = payload[0]
        self.type = ApduType.from(rawValue: typeByte)
        
        // Example of extracting other parts of the APDU message
        // The following are placeholders and must be adjusted according to your actual APDU structure
        
        // Assuming the next 2 bytes could be an invokeId for simplicity (Big Endian)
        if payload.count >= 3 {
            let invokeIdRange = 1..<3
            self.invokeId = Int(payload[invokeIdRange].reduce(0) { result, byte in
                return (result << 8) | Int(byte)
            })
        } else {
            self.invokeId = -1 // Indicate an error or unknown invoke ID
        }
        
        // Assuming the rest of the payload is data
        if payload.count > 3 {
            self.data = payload.subdata(in: 3..<payload.count)
        } else {
            self.data = Data()
        }
        
        // Additional parsing logic should be implemented based on the specific APDU structure
    }
}
