import ScrechKit

struct GoidaBatteryView: View {
    private var model = BatteryVM()
    
    var body: some View {
        List {
            ListParameter("Battery level", parameter: model.batteryLevel)
            ListParameter("Battery state", parameter: model.batteryState)
        }
        .navigationTitle("Battery")
    }
}

#Preview {
    NavigationView {
        GoidaBatteryView()
    }
}
