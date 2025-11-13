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
                ListParam("Max Photo Resolution", param: vm.frontMaxPhotoResolution)
                
                ListParam("Apperture", param: vm.frontApperture)
                
                ListParam("Optical Stabilization", param: vm.frontOpticalStabilization)
            }
        }
        .navigationTitle("Camera")
    }
}

#Preview {
    GoidaCameraView()
}
