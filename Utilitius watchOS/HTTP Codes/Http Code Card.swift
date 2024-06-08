import SwiftUI

struct HttpCodeCard: View {
    private let code: HTTPStatusCode
    
    init(_ code: HTTPStatusCode) {
        self.code = code
    }
    
    var body: some View {
        HStack {
            Text(code.code)
            
            Spacer()
            
            Text(code.name)
                .footnote()
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    List {
        HttpCodeCard(.init(228, name: "Preview", description: "Pyzh"))
    }
}
