import ScrechKit
import AVFAudio

@Observable
final class RecorderVM: NSObject, AVAudioRecorderDelegate {
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer?
    
    var recordedFiles: [AudioFile] = []
    var buttonText: String?
    
    override init() {
        super.init()
        setup()
        updateRecordedFiles()
    }
    
    func setup() {
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            
            AVAudioApplication.requestRecordPermission { allowed in
                main {
                    if allowed {
                        self.buttonText = "Tap to Record"
                    } else {
                        print("Failed to record")
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func startRecording() {
        guard let directory = getDocumentsDirectory() else {
            print("Failed to fetch document directory")
            return
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let filename = dateFormatter.string(from: Date()) + ".m4a"
        
        let audioFilename = directory.appendingPathComponent(filename)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            buttonText = "Tap to Stop"
        } catch {
            print("Failed to start recording")
            finishRecording(success: false)
        }
    }
    
    func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            buttonText = "Tap to Re-record"
        } else {
            buttonText = "Tap to Record"
        }
        
        updateRecordedFiles()
    }
    
    // MARK: - Files
    func updateRecordedFiles() {
        guard let directory = getDocumentsDirectory() else { return }
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            
            recordedFiles = fileURLs.compactMap { url -> AudioFile? in
                do {
                    let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
                    let creationDate = attributes[.creationDate] as? Date
                    let fileSize = attributes[.size] as? Int64
                    
                    if let audioPlayer = try? AVAudioPlayer(contentsOf: url) {
                        let length = audioPlayer.duration
                        return AudioFile(name: url.lastPathComponent, creationDate: creationDate, length: length, size: fileSize)
                    }
                } catch {
                    print("Couldn't read file attributes")
                }
                return nil
            }
        } catch {
            print("Couldn't read directory")
        }
    }
    
    func getDocumentsDirectory() -> URL? {
        guard let iCloudDocumentsURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents") else { return nil }
        
        if !FileManager.default.fileExists(atPath: iCloudDocumentsURL.path) {
            do {
                try FileManager.default.createDirectory(at: iCloudDocumentsURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                return nil
            }
        }
        
        return iCloudDocumentsURL
    }
    
    func deleteRecording(at offsets: IndexSet) {
        guard let directory = getDocumentsDirectory() else { return }
        
        for index in offsets {
            let filename = recordedFiles[index].name
            let fileURL = directory.appendingPathComponent(filename)
            
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                print("Couldn't remove file")
            }
        }
        
        updateRecordedFiles()
    }
    
    // MARK: - Player
    func playRecording(_ filename: String) {
        guard let directory = getDocumentsDirectory() else { return }
        let audioURL = directory.appendingPathComponent(filename)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
            audioPlayer?.play()
        } catch {
            print("Couldn't load file")
        }
    }
}
