import ScrechKit

struct GoidaCameraView: View {
    private var model = CameraVM()
    
    var body: some View {
        List {
#if DEBUG
            Button("Front camera test") {
                model.fetchCameraData(.front)
            }
            
            Button("Back camera test") {
                model.fetchCameraData(.back)
            }
#endif
            Section("Front Camera") {
                ListParameter("Max Photo Resolution", parameter: model.frontMaxPhotoResolution)
                ListParameter("Apperture", parameter: model.frontApperture)
                ListParameter("Optical Stabilization", parameter: model.frontOpticalStabilization)
            }
        }
        .navigationTitle("Camera")
    }
}

#Preview {
    GoidaCameraView()
}
