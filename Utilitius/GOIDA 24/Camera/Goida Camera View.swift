import ScrechKit

struct GoidaCameraView: View {
    private var vm = CameraVM()
    
    var body: some View {
        List {
#if DEBUG
            Button("Front camera test") {
                vm.fetchCameraData(.front)
            }
            
            Button("Back camera test") {
                vm.fetchCameraData(.back)
            }
#endif
            Section("Front Camera") {
                LabeledContent("Max Photo Resolution", value: vm.frontMaxPhotoResolution)
                
                LabeledContent("Apperture", value: vm.frontApperture)
                
                LabeledContent("Optical Stabilization", value: vm.frontOpticalStabilization)
            }
        }
        .navigationTitle("Camera")
    }
}

#Preview {
    GoidaCameraView()
}
