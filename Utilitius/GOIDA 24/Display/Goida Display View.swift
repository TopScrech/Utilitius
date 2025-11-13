import ScrechKit

struct Goida_Display_View: View {
    private var display = DisplayVM()
    
    var body: some View {
        List {
            Section("Display") {
                ListParam("Screen resolution", param: display.fetchScreenResolution())
                ListParam("Refresh rate", param: display.refreshRate)
                ListParam("Brightness", param: display.brightness)
            }
        }
        .navigationTitle("Display")
    }
}

#Preview {
    Goida_Display_View()
}
