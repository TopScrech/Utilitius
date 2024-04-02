import Foundation


func decodePHDPayload(_ payload: Data) -> PHDData? {
    var cursor = 0

    // Ensure there's enough data for the entire structure
    guard payload.count >= cursor + 1 + MemoryLayout<Double>.size else { return nil }

    let measurementTypeByte = payload[cursor]
    let measurementType = interpretMeasurementType(measurementTypeByte)
    cursor += 1
    
    // Extracting the measurement value considering potential misalignment
    let measurementValueData = payload.subdata(in: cursor..<(cursor + MemoryLayout<Double>.size))
    cursor += MemoryLayout<Double>.size

//    guard let measurementValue = measurementValueData.withUnsafeBytes({ ptr -> Double? in
//        // Ensure the pointer is properly aligned for a Double
//        guard let baseAddress = ptr.baseAddress else { return nil }
//        let boundPtr = baseAddress.assumingMemoryBound(to: Double.self)
//        // Here, instead of byte-swapping directly which may not be safe due to alignment,
//        // we copy the bytes into a new variable if needed.
//        // Assuming the data is little-endian; adjust if your data is big-endian.
//        return boundPtr.pointee
//    }) else { return nil }
    
    guard let measurementValue = measurementValueData.withUnsafeBytes({ ptr -> Double? in
        let bytes = Array(ptr)
        let reversedBytes = Data(bytes.reversed()) // Reverse the bytes for big-endian data
        return reversedBytes.withUnsafeBytes { $0.load(as: Double.self) }
    }) else { return nil }

    // Assuming there's at least one more byte for the unit of measure
    let measurementUnitByte = payload[cursor]
    let measurementUnit = interpretMeasurementUnit(measurementUnitByte)

    return PHDData(
        measurementType: measurementType,
        measurementValue: measurementValue,
        measurementUnit: measurementUnit
    )
}


struct PHDData {
    var measurementType: String
    var measurementValue: Double
    var measurementUnit: String
    // Additional fields as required by the PHD standard
}

//func decodePHDPayload(_ payload: Data) -> PHDData? {
//    var cursor = 0
//    
//    // Interpret the first byte as the measurement type
//    let measurementTypeByte = payload[cursor]
//    cursor += 1
//    let measurementType = interpretMeasurementType(measurementTypeByte)
//    
//    // Extract the next 8 bytes for the measurement value
//    guard payload.count >= cursor + 8 else { return nil } // Ensure there's enough data
//    let measurementValueData = payload[cursor..<cursor+8]
//    cursor += 8
//    
//    let measurementValue: Double? = measurementValueData.withUnsafeBytes { rawPtr -> Double? in
//        // Ensure there are enough bytes to read a UInt64
//        guard rawPtr.count >= 8 else { return nil }
//
//        // Copy bytes into a UInt64 variable to ensure proper alignment
//        var alignedUInt64 = UInt64(0)
//        withUnsafeMutableBytes(of: &alignedUInt64) { alignedPtr in
//            alignedPtr.copyMemory(from: rawPtr.prefix(8))
//        }
//        
//        // Adjust for endianess if necessary (e.g., if data is big-endian, swap bytes)
//        let endianAdjustedUInt64 = alignedUInt64.byteSwapped // Only do this if you know the data is big-endian
//
//        // Convert the UInt64 back to Double
//        let value = Double(bitPattern: endianAdjustedUInt64)
//        
//        return value
//    }
//
//    guard let unwrappedMeasurementValue = measurementValue else { return nil }
//    
//    // Interpret the next byte as the unit of measure
//    guard payload.count > cursor else { return nil } // Ensure there's more data
//    let measurementUnitByte = payload[cursor]
//    let measurementUnit = interpretMeasurementUnit(measurementUnitByte)
//    
//    return PHDData(
//        measurementType: measurementType,
//        measurementValue: unwrappedMeasurementValue,
//        measurementUnit: measurementUnit
//    )
//}

func interpretMeasurementType(_ byte: UInt8) -> String {
    // Implement based on the PHD standard
    // Example placeholder
    switch byte {
    case 0x01: "Temperature"
    case 0x02: "Heart Rate"
    default: "Unknown"
    }
}

func interpretMeasurementUnit(_ byte: UInt8) -> String {
    // Implement based on the PHD standard
    // Example placeholder
    switch byte {
    case 0x01: "Celsius"
    case 0x02: "Beats per Minute"
    default: "Unknown"
    }
}
