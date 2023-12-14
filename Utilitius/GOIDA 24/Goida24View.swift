import ScrechKit

struct Goida24View: View {
    var body: some View {
        List {
            GoidaListLink("Device and system", icon: "iphone") {
                GoidaDeviceView()
            }
            
            GoidaListLink("Memory", icon: "memorychip") {
                Goida_Memory_View()
            }
            
            GoidaListLink("Camera", icon: "camera") {
                GoidaCameraView()
            }
            
            GoidaListLink("Battery", icon: "battery.100percent.bolt") {
                GoidaBatteryView()
            }
            
            GoidaListLink("Network", icon: "network") {
                Goida_Network_View()
            }
            
            GoidaListLink("Sensors", icon: "barometer") {
                Goida_Sensors_View()
            }
            
            Section {
                NavigationLink("Tests") {
                    GoidaTestList()
                }
            }
        }
        .navigationTitle("GOIDA24")
    }
}

#Preview {
    NavigationView {
        Goida24View()
    }
}
