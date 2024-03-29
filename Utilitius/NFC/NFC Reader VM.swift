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

@Observable
final class NFCReaderVM: NSObject, NFCNDEFReaderSessionDelegate {
    var content = ""
    var contentMessages: [String] = []
    var sheetNFCReader = false
    
    func startSession() {
        let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: false)
        session.begin()
    }
    
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {}
    
    // Called when the reader session becomes invalid due to an error
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("Session invalidated: \(error.localizedDescription)")
    }
    
    // Called when the reader session detects NDEF messages and Process it
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        for message in messages {
            for record in message.records {
                if let payloadString = String(data: record.payload, encoding: .utf8) {
                    contentMessages = [payloadString]
                    print("NDEF message detected: \(payloadString)")
                }
            }
        }
        
        content = messages.description
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            session.invalidate()
            self.sheetNFCReader = true
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
