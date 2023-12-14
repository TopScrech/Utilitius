import ScrechKit

struct GoidaDeviceView: View {
    private var model = DeviceVM()
    //    private var bluetooth = BluetoothManager()
    //    let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString
    
    var body: some View {
        List {
            Section("Device") {
                ListParameter("Device", parameter: model.deviceName)
                ListParameter("Model", parameter: model.deviceIdentifier ?? "-")
                ListParameter("Architecture", parameter: model.architecture)
            }
            
            Section("System") {
                ListParameter("Operating system", parameter: model.operatingSystem)
                ListParameter("Build number", parameter: model.buildNumber)
            }
            
            Section {
                ListParameter("System language", parameter: Locale.current.identifier)
                ListParameter("System region", parameter: Locale.current.region?.identifier ?? "-")
                ListParameter("System uptime", parameter: model.fetchSystemUptime())
            }
            
            Section("Capabilities") {
                ListParameter("NFC", parameter: model.isNfcAvailable)
                ListParameter("Ultra Wideband", parameter: model.isUltraWidebandAvailable)
                ListParameter("Force Touch", parameter: model.isForceTouchAvailable)
                //                ListParameter("Bluetooth LE", parameter: bluetooth.isBluetoothLeEnabled)
            }
        }
        .navigationTitle("Device")
    }
}

#Preview {
    GoidaDeviceView()
}
