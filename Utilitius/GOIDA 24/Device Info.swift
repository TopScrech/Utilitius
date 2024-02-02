#if canImport(NearbyInteraction)
import NearbyInteraction

final class DeviceInfo {
    static var isUltraWidebandAvailable: Bool {
        if #available(iOS 16.0, watchOS 9.0, *) {
            NISession.deviceCapabilities.supportsPreciseDistanceMeasurement
        } else {
            NISession.isSupported
        }
    }
}

#endif
