import SwiftUI

struct MathView: View {
    @State private var textField = ""
    
    private var number: Double {
        sqrt(Double(textField) ?? 0)
    }
    
    var body: some View {
        VStack {
            TextField("Number", text: $textField)
                .multilineTextAlignment(.center)
            
            Text("Square root of \(textField) is \(number)")
        }
    }
}

#Preview {
    MathView()
}
