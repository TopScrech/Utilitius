import SwiftUI
import RealityKit
import RealityKitContent

struct HomeView: View {
    @Environment(\.openWindow) private var openWindow
    
    var body: some View {
        TabView {
            VStack {
                Button("Test") {
                    openWindow(id: "test")
                }
            }
//            NavigationLink {
//            } label: {
//                VStack {
//                    Text("Notes")
//                }
//            }
            .tag(1)
            .tabItem {
                Label("Productivity", systemImage: "note.text")
            }
                        
            NavigationLink {
                
            } label: {
                VStack {
                    Text("Dev")
                }
            }
            .tag(2)
            .tabItem {
                Label("Dev", systemImage: "hammer")
            }
        }
        .navigationTitle("Utilitius")
        .ornament(attachmentAnchor: .scene(.top)) {
            HStack {
                Button {
                    
                } label: {
                    Label("Test", systemImage: "hammer")
                }
                
                Text("122131241")
            }
            .frame(height: 200)
            .offset(y: -50)
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
