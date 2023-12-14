import ScrechKit

struct AppContainer: View {
    @Bindable private var navState = NavState()
    
    var body: some View {
        NavigationStack(path: $navState.path) {
            AppList()
                .withNavDestinations()
        }
        .environment(navState)
    }
}
