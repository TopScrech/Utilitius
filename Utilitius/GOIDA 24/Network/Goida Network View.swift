import ScrechKit

struct Goida_Network_View: View {
    private var network = NetworkVM()
    private var wifi = WifiVM()
    
    var body: some View {
        List {
            if let ipAddress = network.getIPAddress() {
                LabeledContent("IP-address", value: ipAddress)
            }
            
            Section("Wi-Fi") {
                LabeledContent("Connected to...", value: wifi.networkStatus)
                LabeledContent("Name", value: wifi.ssid)
                LabeledContent("Address", value: wifi.bssid)
            }
        }
        .navigationTitle("Network")
    }
}

#Preview {
    Goida_Network_View()
}
