//
//  PHD.swift
//  Utilitius
//
//  Created by Sergei Saliukov on 01/04/2024.
//

import Foundation
struct PHDData {
    var measurementType: String
    var measurementValue: Double
    var measurementUnit: String
    // Additional fields as required by the PHD standard
}

func decodePHDPayload(_ payload: Data) -> PHDData? {
    // Example decoding logic, adjust based on actual PHD data structure
    var cursor = 0
    
    // Suppose the first byte defines the measurement type
    let measurementTypeByte = payload[cursor]
    cursor += 1
    let measurementType = interpretMeasurementType(measurementTypeByte)
    
    // Suppose the next 8 bytes are the measurement value in IEEE floating-point format
    let measurementValueData = payload[cursor..<cursor+8]
    cursor += 8
    
    
    
    
    //    let measurementValue = measurementValueData.withUnsafeBytes { $0.load(as: Double.self) }
    let measurementValue: Double = measurementValueData.withUnsafeBytes { ptr in
        // Create a new instance from the bytes, avoiding direct load from misaligned pointer
        return ptr.bindMemory(to: Double.self).baseAddress!.pointee
    }
    
    
    
    
    // Suppose the next byte defines the unit of measure
    let measurementUnitByte = payload[cursor]
    let measurementUnit = interpretMeasurementUnit(measurementUnitByte)
    
    return PHDData(
        measurementType: measurementType,
        measurementValue: measurementValue,
        measurementUnit: measurementUnit
    )
}

// Placeholder functions to interpret measurement type and unit from bytes
func interpretMeasurementType(_ byte: UInt8) -> String {
    // Implement based on PHD standard
    return ""
}

func interpretMeasurementUnit(_ byte: UInt8) -> String {
    // Implement based on PHD standard
    return ""
}
