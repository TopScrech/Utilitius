import SwiftUI

struct UWTestView: View {
    private var model = NearbyVM()
    
    var body: some View {
        @Bindable var binding = model
        
        VStack(spacing: 20) {
            Text(model.distance)
                .title(.bold)
                .animation(.easeIn, value: model.distance)
                .numericTransition()
            
            Text(model.connectedDeviceName)
            
            //            Text(model.status)
            
            HStack {
                Image(systemName: "arrow.turn.up.left")
                    .foregroundStyle(model.azimuthText.contains("-") ? .primary : .secondary)
                
                Text(model.azimuthText)
                    .monospaced()
                    .padding(.horizontal, 5)
                    .foregroundStyle(model.currentDistanceDirectionState == .unknown ||
                                     model.currentDistanceDirectionState == .outOfFOV ? .red : .primary)
                
                Image(systemName: "arrow.turn.up.right")
                    .foregroundStyle(model.azimuthText.contains("-") ? .secondary : .primary)
            }
            
            HStack {
                if model.elevationText.contains("-") {
                    Image(systemName: "arrow.down")
                } else {
                    Image(systemName: "arrow.up")
                }
                
                Text(model.elevationText)
                    .monospaced()
                    .foregroundStyle(model.currentDistanceDirectionState == .unknown ||
                                     model.currentDistanceDirectionState == .outOfFOV ? .red : .primary)
            }
            
            //            Text("\(model.monkeyRotationAngle)")
            
            Text(model.monkeyLabel)
                .opacity(1)
                .fontSize(64)
                .rotationEffect(.degrees(model.monkeyRotationAngle * 90))
        }
        .padding()
        .alert(model.alertTitle, isPresented: $binding.showAlert) {
            Button("Go to Settings") {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }
            
            Button("Cancel") {}
        } message: {
            Text(model.alertMessage)
        }
    }
}

#Preview {
    UWTestView()
}
