import ScrechKit

extension View {
    func withNavDestinations() -> some View {
        self.navigationDestination(for: NavDestinations.self) { destination in
            switch destination {
            case .toStopwatch: StopwatchView()
            case .toReminder: ReminderList()
            }
        }
    }
}
