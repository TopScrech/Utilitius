import YouTubeKit
import AVFoundation

@Observable
final class YTDownloaderVM {
    var stringUrl = ""
    
    func test() async {
        //    https://youtu.be/YQRHrco73g4?si=oKMq0CPB9NeFg36-
        let youtube = YouTube(videoID: "trnx5XT0cZs")
        //        let youtube = YouTube(videoID: "9bZkp7q19f0")
        
        do {
            let streams = try await youtube.streams
            
            let bestVideoStream = streams
                .highestResolutionStream()
            
            let bestAudoiStream = streams
                .highestAudioBitrateStream()
            
            print(bestVideoStream?.url ?? "Fail")
            print(bestAudoiStream?.url ?? "Fail")
        } catch {
            print("Fail")
        }
    }
}
