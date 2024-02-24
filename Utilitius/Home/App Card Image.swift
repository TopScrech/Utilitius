import SwiftUI

struct AppCardImage: View {
    private let name: String
    private let image: Image
    
    init(
        _ name: String,
        image: Image
    ) {
        self.name = name
        self.image = image
    }
    
    var body: some View {
        VStack {
            image
                .resizable()
                .frame(width: 64, height: 64)
                .clipShape(.rect(cornerRadius: 16))
            
            Text(name)
                .rounded()
        }
    }
}

//#Preview {
//    AppCardImage("Preview", image: Image(.error404))
//}
