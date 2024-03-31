#if canImport(CoreNFC)
import SwiftUI
import CoreNFC
import os

struct NFCMessageType {
    let id: Int
    let name: String
    let prefix: String
    let placeholder: String
    
    init(_ id: Int, name: String, prefix: String, placeholder: String) {
        self.id = id
        self.name = name
        self.prefix = prefix
        self.placeholder = placeholder
    }
}

let nfcMessageTypes: [NFCMessageType] = [
    .init(1, name: "Text", prefix: "", placeholder: "Hello, World!"),
    .init(2, name: "Web Link", prefix: "https://", placeholder: "www.example.com"),
    .init(3, name: "E-mail", prefix: "mailto:", placeholder: "user@example.com"),
    .init(4, name: "SMS", prefix: "sms:", placeholder: "+14085551212"),
    .init(5, name: "Telephone", prefix: "tel:", placeholder: "+14085551212"),
    .init(6, name: "FaceTime", prefix: "facetime:", placeholder: "user@example.com"),
    .init(7, name: "FaceTime Audio", prefix: "facetime-audio:", placeholder: "user@example.com"),
    .init(8, name: "Telegram", prefix: "tg://resolve?domain=", placeholder: "TopScrech"),
    .init(9, name: "Instagram", prefix: "instagram://user?username=", placeholder: "TopScrech"),
    .init(10, name: "Whatsapp", prefix: "whatsapp://send?phone=", placeholder: "+14085551212")//,
    
    //    .init("Maps", prefix: "", placeholder: ""),
    //    .init("Wifi", prefix: "", placeholder: ""),
    //    .init("Shortcut", prefix: "", placeholder: ""),
    //    .init("Business Card", prefix: "", placeholder: "")
]

class NFCReaderViewModel: NSObject, NFCTagReaderSessionDelegate, ObservableObject {
    var session: NFCTagReaderSession?
    
    func beginSession() {
        guard NFCNDEFReaderSession.readingAvailable else {
            return
        }
        
        session = NFCTagReaderSession(pollingOption: [.iso14443, .iso15693, .iso18092], delegate: self, queue: nil)
        session?.alertMessage = "Hold your iPhone near the NFC tag."
        session?.begin()
    }
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        os_log("The NFC tag reader session is active.")
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        if let firstTag = tags.first {
            session.connect(to: firstTag) { (error: Error?) in
                if let error = error {
                    session.invalidate(errorMessage: "Connection failed: \(error.localizedDescription)")
                    return
                }
                
                switch firstTag {
                case let .iso7816(tag):
                    // Handle ISO 7816 tag
                    // You can perform APDU commands here
                    break
                default:
                    session.invalidate(errorMessage: "Tag type not supported.")
                    break
                }
            }
        }
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        os_log("The NFC tag reader session is invalidated due to error: %@", type: .error, error.localizedDescription)
    }
    
    // Add additional methods to handle ISO7816 commands and responses
    // ...
}


@Observable
final class NFCReaderVM: NSObject, NFCNDEFReaderSessionDelegate {
    var content = ""
    var contentMessages: [String] = []
    var sheetNFCReader = false
    
    func startSession() {
        let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session.begin()
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        
    }
    
    // Called when the reader session becomes invalid due to an error
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Session invalidated: \(error.localizedDescription)")
    }
    
    func decodeTextPayload(_ payload: Data) -> String? {
        guard payload.count > 1 else { return nil }
        
        let statusByte = payload[0]
        let encoding = (statusByte & 0x80) == 0 ? String.Encoding.utf8 : String.Encoding.utf16
        let languageCodeLength = Int(statusByte & 0x3F)
        
        guard payload.count > 1 + languageCodeLength else { return nil }
        
        let textData = payload.subdata(in: (1 + languageCodeLength)..<payload.count)
        
        return String(data: textData, encoding: encoding)
    }
    
    func printHexadecimalString(_ data: Data) -> String {
        let hexString = data.map {
            String(format: "%02hhx", $0)
        }.joined()
        
        print("Payload Hex: \(hexString)")
        
        return hexString
    }
    
    func hexStringToData(_ hex: String) -> Data {
        var data = Data()
        var hexIndex = hex.startIndex
        
        while hexIndex < hex.endIndex {
            let nextIndex = hex.index(hexIndex, offsetBy: 2)
            if nextIndex <= hex.endIndex {
                let byteString = hex[hexIndex..<nextIndex]
                if let byte = UInt8(byteString, radix: 16) {
                    data.append(byte)
                }
            }
            hexIndex = nextIndex
        }
        
        return data
    }
    
    let uriPrefixes: [UInt8: String] = [
        0x00: "",
        0x01: "http://www.",
        0x02: "https://www.",
        0x03: "http://",
        0x04: "https://",
        0x05: "tel:",
        0x06: "mailto:",
        // Add more prefixes as needed based on the NFC Forum URI RTD
    ]

//    func processNDEFRecord(_ record: NFCNDEFPayload) {
//        switch record.typeNameFormat {
//        case .nfcWellKnown:
//            if let text = decodeTextPayload(record.payload) {
//                print("Decoded text: \(text)")
//            } else if let uri = decodeURIPayload(record.payload) {
//                print("Decoded URI: \(uri)")
//            }
//        // Add more cases as needed
//        default:
//            print("Unsupported type name format")
//        }
//    }
    func processNDEFRecord(_ record: NFCNDEFPayload) {
        // Example: Assuming PHD data might be in a record with a specific type
        // You might need to adjust this logic based on how PHD data is actually stored in the NDEF record
        if record.typeNameFormat == .nfcWellKnown {
            // Attempt to decode the payload as PHD data
            if let phdData = decodePHDPayload(record.payload) {
                print("Decoded PHD Data: \(phdData)")
                // Handle the decoded PHD data as needed
            } else {
                print("Failed to decode PHD data from payload")
            }
        }
    }

//    func processNDEFRecord(_ record: NFCNDEFPayload) {
//        // Check if the record's type name format indicates a well-known type
//        if record.typeNameFormat == .nfcWellKnown {
//            // Try decoding as a URI
//            print("well known")
//            
//            if let uri = decodeCustomPayload(record.payload) {
//                print("Decoded URI: \(uri)")
//            } else {
//                print("uri nil")
//            }
//        }
//        // Handle other type name formats as needed
//    }
    
    func decodeCustomPayload(_ payload: Data) -> String? {
        // Implement custom decoding logic based on the payload structure
        // Example: assuming the payload contains ASCII encoded string starting from the second byte
        if let customString = String(data: payload.subdata(in: 1..<payload.count), encoding: .ascii) {
            return customString
        }
        return nil
    }

//    func decodeURIPayload(_ payload: Data) -> String? {
//        guard payload.count > 1 else { return nil }
//        
//        let identifierCode = payload[0] // URI Identifier Code
//        
//        guard let uriPrefix = uriPrefixes[identifierCode],
//              let uriContent = String(data: payload.subdata(in: 1..<payload.count), encoding: .utf8) else {
//            return nil
//        }
//        
//        return uriPrefix + uriContent
//    }

    // Called when the reader session detects NDEF messages and Process it
//    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
//        for message in messages {
//            for record in message.records {
//                processNDEFRecord(record)
//                
//                print("Type name format: \(record.typeNameFormat)")
//                print("Payload: \(record.payload.count) bytes")
//                print("Type: \(record.type.count) bytes")
//                print("Identifier: \(record.identifier.count) bytes")
//                
////                switch record.typeNameFormat {
////                case .absoluteURI: print("1")
////                case .empty: print("2")
////                case .media: print("3")
////                case .nfcExternal: print("4")
////                case .nfcWellKnown: print("5")
////                    
////                case .unchanged: print("6")
////                case .unknown: print("7")
////                }
//                
//                // Attempt to decode payload as a UTF-8 string
//                if let payloadString = String(data: record.payload.advanced(by: 1), encoding: .utf8) {
//                    print("NDEF message detected: \(payloadString)")
//                } else {
//                    print("Could not decode payload as UTF-8 string")
//                }
//                
//                if let payloadString = decodeTextPayload(record.payload) {
//                    print(payloadString)
//                } else {
//                    print("decodeTextPayload unsucceeded")
//                }
//                
//                let hexString = printHexadecimalString(record.payload)
//                
//                let payloadData = hexStringToData(hexString)
//                
////                for byte in payloadData {
////                    print(byte)
////                }
//            }
//            
//            // 00e2000032800000000001002a507900268000000080008000000000000000008000000008001465004010cb23400a0001010000000000
//            // 00e2000032800000000001002a507900268000000080008000000000000000008000000008001465004010cb23400a0001010000000000
//            
//            // 00e2000032800000000001002a507900268000000080008000000000000000008000000008001465004010cb23400a0001010000000000
//            
//            //            for record in message.records {
//            //            if let payloadString = String(data: record.payload, encoding: .utf8) {
//            //                contentMessages = [payloadString]
//            //                print("NDEF message detected: \(payloadString)")
//            //            }
//            //            }
//        }
//        
//        content = messages.description
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//            session.invalidate()
//            self.sheetNFCReader = true
//        }
//    }
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
//    func readerSession(_ session: NFCTagReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                processNDEFRecord(record)
            }
        }
    }
}

@Observable
final class NFCWriterVM: NSObject, NFCNDEFReaderSessionDelegate {
    var readerSession: NFCNDEFReaderSession?
    var ndefMessage: NFCNDEFMessage?
    var alertMessage: String?
    var alertError = false
    var textField = ""
    //    var selectedNfcMessageType = 0
    //
    //    var message: String {
    //        nfcMessageTypes[selectedNfcMessageType].prefix + textField
    //    }
    //
    //    var prefix: String {
    //        nfcMessageTypes[selectedNfcMessageType].prefix
    //    }
    //
    //    var placeholder: String {
    //        nfcMessageTypes[selectedNfcMessageType].placeholder
    //    }
    
    func writeTag() {
        guard NFCNDEFReaderSession.readingAvailable else {
            alertMessage = "This device doesn't support tag scanning."
            alertError = true
            return
        }
        
        readerSession = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        readerSession?.alertMessage = "Hold your iPhone near a writable NFC tag to update."
        readerSession?.begin()
    }
    
    func tagRemovalDetect(_ tag: NFCNDEFTag) {
        // In the tag removal procedure, you connect to the tag and query for
        // its availability. You restart RF polling when the tag becomes
        // unavailable; otherwise, wait for certain period of time and repeat
        // availability checking.
        self.readerSession?.connect(to: tag) { (error: Error?) in
            if error != nil || !tag.isAvailable {
                os_log("Restart polling")
                self.readerSession?.restartPolling()
                return
            }
            
            DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
                self.tagRemovalDetect(tag)
            }
        }
    }
    
    // MARK: - NFCNDEFReaderSessionDelegate
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        
        let textPayload = NFCNDEFPayload.wellKnownTypeTextPayload(
            string: "Bisquit.Host",
            locale: Locale(identifier: "En")
        )
        
        let urlPayload = NFCNDEFPayload.wellKnownTypeURIPayload(string: textField)
        //        let urlPayload = NFCNDEFPayload.wellKnownTypeTextPayload(string: messageToWrite, locale: Locale.autoupdatingCurrent)
        ndefMessage = NFCNDEFMessage(records: [urlPayload!, textPayload!])
        os_log("MessageSize=%d", ndefMessage!.length)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {}
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {}
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetect tags: [NFCNDEFTag]) {
        if tags.count > 1 {
            session.alertMessage = "More than 1 tags found. Please present only 1 tag."
            self.tagRemovalDetect(tags.first!)
            return
        }
        
        // You connect to the desired tag.
        let tag = tags.first!
        session.connect(to: tag) { (error: Error?) in
            if error != nil {
                session.restartPolling()
                return
            }
            
            // You then query the NDEF status of tag.
            tag.queryNDEFStatus() { (status: NFCNDEFStatus, capacity: Int, error: Error?) in
                if error != nil {
                    session.invalidate(errorMessage: "Fail to determine NDEF status.  Please try again.")
                    return
                }
                
                if status == .readOnly {
                    session.invalidate(errorMessage: "Tag is not writable.")
                } else if status == .readWrite {
                    if self.ndefMessage!.length > capacity {
                        session.invalidate(errorMessage: "Tag capacity is too small.  Minimum size requirement is \(self.ndefMessage!.length) bytes.")
                        return
                    }
                    
                    // When a tag is read-writable and has sufficient capacity,
                    // write an NDEF message to it
                    tag.writeNDEF(self.ndefMessage!) { (error: Error?) in
                        if error != nil {
                            session.invalidate(errorMessage: "Update tag failed. Please try again.")
                        } else {
                            session.alertMessage = "Update success!"
                            session.invalidate()
                        }
                    }
                } else {
                    session.invalidate(errorMessage: "Tag is not NDEF formatted.")
                }
            }
        }
    }
}

#endif
