import SwiftUI

struct StatusCodeCard: View {
    private let code: HTTPStatusCode
    
    init(_ code: HTTPStatusCode) {
        self.code = code
    }
    
    @State private var alertInfo = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                Text(String(code.code))
                    .bold()
                
                Text(code.name)
                    .monospaced()
                
                if !code.description.isEmpty {
                    Spacer()
                    
                    Button {
                        alertInfo = true
                    } label: {
                        Image(systemName: "info.circle")
                            .semibold()
                    }
                }
            }
            .padding(.bottom, 5)
        }
        .alert("\(code.code) \(code.name)", isPresented: $alertInfo) {
            
        } message: {
            Text(code.description)
        }
    }
}

#Preview {
    List {
        StatusCodeCard(httpStatusCodes.first {
            $0.code == 418
        }!)
    }
}
