import Foundation

extension UInt64 {
    var data: Data {
        var value = self
        return Data(bytes: &value, count: MemoryLayout<UInt64>.size)
    }
}
