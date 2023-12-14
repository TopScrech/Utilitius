enum NavDestinations: Hashable {
    case toNote(Note)
    case toEditor(_ countdown: Countdown)
    case toXcodes
    case toBuildTime
    case toHttpStatusCodes
    case toFrameworkList
    case toInventory
    case toNotes
    case toNFCScan
    case toOTP
    case toTimer
    case toReminder
    case toSavedNfcMessages
    case toMorse
    case toGoida24
    case toStopwatch
    case toVoiceMemos
    case toInventoryItem(_ item: InventoryItem)
    case toMath
}
