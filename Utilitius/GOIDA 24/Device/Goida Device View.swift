import ScrechKit

struct GoidaDeviceView: View {
    private var vm = DeviceVM()
    //    private var bluetooth = BluetoothManager()
    //    let deviceIdentifier = UIDevice.current.identifierForVendor?.uuidString
    
    var body: some View {
        List {
            Section("Device") {
                ListParam("Device", param: vm.deviceName)
                ListParam("Model", param: vm.deviceIdentifier ?? "-")
                ListParam("Architecture", param: vm.architecture)
            }
            
            Section("System") {
                ListParam("Operating system", param: vm.operatingSystem)
                ListParam("Build number", param: vm.buildNumber)
            }
            
            Section {
                ListParam("System language", param: Locale.current.identifier)
                ListParam("System region", param: Locale.current.region?.identifier ?? "-")
                ListParam("System uptime", param: vm.fetchSystemUptime())
                ListParam("System uptime", param: vm.thermalState)
            }
            
            Section("Capabilities") {
                ListParam("NFC", param: vm.isNfcAvailable)
                ListParam("Ultra Wideband", param: vm.isUltraWidebandAvailable)
                ListParam("Force Touch", param: vm.isForceTouchAvailable)
                //                ListParam("Bluetooth LE", param: bluetooth.isBluetoothLeEnabled)
            }
        }
        .navigationTitle("Device")
    }
}

#Preview {
    GoidaDeviceView()
}
