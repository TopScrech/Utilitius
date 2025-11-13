import Foundation

let previewTag = Tag()

//let previewCountdown = Countdown(name: "New Countdown", icon: "⏰", note: "", deadline: Date(), attachedUrl: nil)

let previewNote = Note(
    title: "Preview",
    text: "---"
)

//let previewInventoryItem = InventoryItem(
//    name: "Preview Item",
//    itemDescription: "Preview Description",
//    count: 16
//)

func formatBytes<T: BinaryInteger>(
    _ bytes: T,
    countStyle: ByteCountFormatter.CountStyle
) -> String {
    let formatter = ByteCountFormatter()
    formatter.allowedUnits = .useAll
    formatter.countStyle = countStyle
    formatter.includesUnit = true
    
    return formatter.string(fromByteCount: Int64(bytes))
}
