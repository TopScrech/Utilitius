import SwiftUI

struct FrameworkListView: View {
    private var vm = FrameworkModel()
    
    var body: some View {
        List {
            ForEach(vm.frameworks, id: \.name) { framework in
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
