import ScrechKit

struct GoidaBatteryView: View {
    private var vm = BatteryVM()
    
    var body: some View {
        List {
            ListParam("Battery level", param: vm.batteryLevel)
            ListParam("Battery state", param: vm.batteryState)
        }
        .navigationTitle("Battery")
    }
}

#Preview {
    NavigationView {
        GoidaBatteryView()
    }
}
