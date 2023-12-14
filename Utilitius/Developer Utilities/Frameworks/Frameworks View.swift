import SwiftUI

struct FrameworkListView: View {
    private var model = FrameworkModel()
    
    var body: some View {
        List {
            ForEach(model.frameworks, id: \.name) { framework in
                Text(framework.name)
            }
        }
        .navigationTitle("Frameworks")
    }
}

#Preview {
    NavigationView {
        FrameworkListView()
    }
}
