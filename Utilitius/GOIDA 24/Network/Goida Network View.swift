import ScrechKit

struct Goida_Network_View: View {
    private var network = NetworkVM()
    private var wifi = WifiVM()
    
    var body: some View {
        List {
            if let ipAddress = network.getIPAddress() {
                ListParam("IP-address", param: ipAddress)
            }
            
            Section("Wi-Fi") {
                ListParam("Connected to...", param: wifi.networkStatus)
                ListParam("Name", param: wifi.ssid)
                ListParam("Address", param: wifi.bssid)
            }
        }
        .navigationTitle("Network")
    }
}

#Preview {
    Goida_Network_View()
}
