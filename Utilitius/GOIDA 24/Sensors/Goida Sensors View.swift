import ScrechKit

struct Goida_Sensors_View: View {
    private var location = LocationVM()
    private var orientation = OrientationVM()
    private var altitude = AltitudeVM()
    private var pressure = PressureVM()
    private var activity = ActivityVM()
    
    var body: some View {
        List {
            Section("Location") {
                LabeledContent("Latitude", value: String(location.latitude))
                LabeledContent("Longitude", value: String(location.longitude))
                
                HStack {
                    Text("True heading")
                    
                    Spacer()
                    
                    Image(systemName: "arrow.up.circle")
                        .title3(.semibold)
                        .foregroundColor((location.trueHeading >= 355 || location.trueHeading <= 5) ? .green : .primary)
                        .rotationEffect(.degrees(location.trueHeading))
                    
                    Text(String(format: "%.1f", location.trueHeading) + "°")
                        .foregroundStyle(.secondary)
                }
            }
            
            Section("Rotation") {
                LabeledContent("Roll", value: orientation.roll)
                LabeledContent("Pitch", value: orientation.pitch)
                LabeledContent("Yaw", value: orientation.yaw)
                LabeledContent("Orientation", value: orientation.orientation)
            }
            
            Section("Acceleration") {
                LabeledContent("X Axis", value: orientation.x)
                LabeledContent("Y Axis", value: orientation.y)
                LabeledContent("Z Axis", value: orientation.z)
            }
            
            Section("Altimeter") {
                LabeledContent("Pressure", value: pressure.pressureKilo)
                LabeledContent("Relative altitude", value: altitude.relativeAltitude)
                LabeledContent("Absolute altitude", value: altitude.absoluteAltitude)
            }
            
            Section("Motion coprocessor") {
                LabeledContent("Activity", value: activity.activity)
                LabeledContent("Confidence", value: activity.confidence)
            }
        }
        .numericTransition()
        .navigationTitle("Sensors")
    }
}

#Preview {
    Goida_Sensors_View()
}
