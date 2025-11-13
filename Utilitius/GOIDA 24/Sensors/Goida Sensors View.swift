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
                ListParam("Latitude", param: String(location.latitude))
                ListParam("Longitude", param: String(location.longitude))
                
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
                ListParam("Roll", param: orientation.roll)
                ListParam("Pitch", param: orientation.pitch)
                ListParam("Yaw", param: orientation.yaw)
                ListParam("Orientation", param: orientation.orientation)
            }
            
            Section("Acceleration") {
                ListParam("X Axis", param: orientation.x)
                ListParam("Y Axis", param: orientation.y)
                ListParam("Z Axis", param: orientation.z)
            }
            
            Section("Altimeter") {
                ListParam("Pressure", param: pressure.pressureKilo)
                ListParam("Relative altitude", param: altitude.relativeAltitude)
                ListParam("Absolute altitude", param: altitude.absoluteAltitude)
            }
            
            Section("Motion coprocessor") {
                ListParam("Activity", param: activity.activity)
                ListParam("Confidence", param: activity.confidence)
            }
        }
        .numericTransition()
        .navigationTitle("Sensors")
    }
}

#Preview {
    Goida_Sensors_View()
}
