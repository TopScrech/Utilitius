import ScrechKit

struct GoidaBatteryView: View {
    private var vm = BatteryVM()
    
    var body: some View {
        List {
            LabeledContent("Battery level", value: vm.batteryLevel)
            LabeledContent("Battery state", value: vm.batteryState)
        }
        .navigationTitle("Battery")
    }
}

#Preview {
    NavigationView {
        GoidaBatteryView()
    }
}
