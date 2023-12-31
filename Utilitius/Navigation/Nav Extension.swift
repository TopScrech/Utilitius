import ScrechKit

extension View {
    func withNavDestinations() -> some View {
        self.navigationDestination(for: NavDestinations.self) { destination in
            switch destination {
            case .toEditor(let countdown):
                CountdownView(countdown)
                
            case .toNote(let note):
                NoteView(note)
                
            case .toXcodes: Xcodes_View()
            case .toBuildTime: BuildTimeView()
            case .toHttpStatusCodes: StatusCodesView()
            case .toFrameworkList: FrameworkListView()
            case .toTimer: TimerList()
            case .toReminder: ReminderParent()
            case .toOTP: OTPList()
            case .toNotes: NoteList()
            case .toInventory: InventoryView()
            case .toNFCScan: NFCScanView()
            case .toVoiceMemos: RecorderView()
            case .toMorse: MorseView()
            case .toStopwatch: StopwatchView()
            case .toGoida24: Goida24View()
            case .toMath: MathView()
            case .toInventoryItem(let item):
                InventoryItem_View(item)
                
            case .toSavedNfcMessages: NFCMessagesView()
            }
        }
    }
}
