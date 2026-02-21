import ScrechKit

struct GoidaDeviceView: View {
    private var vm = DeviceVM()
    //    private var bluetooth = BluetoothManager()
    //    let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString
    
    var body: some View {
        List {
            Section("Device") {
                LabeledContent("Device", value: vm.deviceName)
                LabeledContent("Model", value: vm.deviceIdentifier ?? "-")
                LabeledContent("Architecture", value: vm.architecture)
            }
            
            Section("System") {
                LabeledContent("Operating system", value: vm.operatingSystem)
                LabeledContent("Build number", value: vm.buildNumber)
            }
            
            Section {
                LabeledContent("System language", value: Locale.current.identifier)
                LabeledContent("System region", value: Locale.current.region?.identifier ?? "-")
                LabeledContent("System uptime", value: vm.fetchSystemUptime())
                LabeledContent("System uptime", value: vm.thermalState)
            }
            
            Section("Capabilities") {
                LabeledContent("NFC", value: vm.isNfcAvailable)
                LabeledContent("Ultra Wideband", value: vm.isUltraWidebandAvailable)
                LabeledContent("Force Touch", value: vm.isForceTouchAvailable)
                //                LabeledContent("Bluetooth LE", value: bluetooth.isBluetoothLeEnabled)
            }
        }
        .navigationTitle("Device")
    }
}

#Preview {
    GoidaDeviceView()
}
