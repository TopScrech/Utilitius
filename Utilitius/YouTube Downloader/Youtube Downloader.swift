import SwiftUI
import AVKit

struct YTDownloaderView: View {
    @Bindable private var vm = YTDownloaderVM()
    @State private var player: AVPlayer?
    
    var body: some View {
        List {
            Button("Download") {
                print("Start")
                
                Task {
                    await vm.test()
//                    if let url = await model.test() {
//                        player = AVPlayer(url: url)
//                    }
                }
            }
            
            if let player = player {
                VideoPlayer(player: player)
                    .frame(height: 400)
            }
        }
    }
}

#Preview {
    YTDownloaderView()
}
