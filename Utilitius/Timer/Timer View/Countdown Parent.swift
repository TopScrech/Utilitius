import ScrechKit

struct CountdownParent: View {
    @Bindable private var countdown: Countdown
    
    init(_ countdown: Countdown) {
        self.countdown = countdown
    }
    
    var body: some View {
#if os(watchOS)
        CountdownView(countdown)
#else
        NavigationView {
            CountdownView(countdown)
        }
#endif
    }
}

//#Preview {
//    CountdownParent(previewCountdown)
//}
