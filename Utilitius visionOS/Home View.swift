import SwiftUI
import RealityKit
import RealityKitContent

struct HomeView: View {
    var body: some View {
        VStack {
            NavigationLink {
                
            } label: {
                VStack {
                    Text("Notes")
                }
            }
        }
        .navigationTitle("Utilitius")
        .ornament(attachmentAnchor: .scene(.top)) {
            Button {
                
            } label: {
                Label("Test", systemImage: "hammer")
            }
        }
        .toolbar {
            Button {
                
            } label: {
                Label("Test", systemImage: "hammer")
            }
        }
        //        VStack {
        //            Model3D(named: "Scene", bundle: realityKitContentBundle)
        //                .padding(.bottom, 50)
        //        }
        //        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    NavigationStack {
        HomeView()
    }
}
