import ScrechKit

struct Goida_Display_View: View {
    private var display = DisplayVM()
    
    var body: some View {
        List {
            Section("Display") {
                LabeledContent("Screen resolution", value: display.fetchScreenResolution())
                LabeledContent("Refresh rate", value: display.refreshRate)
                LabeledContent("Brightness", value: display.brightness)
            }
        }
        .navigationTitle("Display")
    }
}

#Preview {
    Goida_Display_View()
}
