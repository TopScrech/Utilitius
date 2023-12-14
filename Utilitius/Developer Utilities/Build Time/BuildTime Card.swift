import SwiftUI

struct BuildTimeCard: View {
    private let name, value: String
    
    init(_ name: String, value: String) {
        self.name = name
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(name)
            
            Spacer()
            
            Text(value)
                .bold()
        }
    }
}

#Preview {
    List {
        BuildTimeCard("Preview", value: "16m")
    }
}
