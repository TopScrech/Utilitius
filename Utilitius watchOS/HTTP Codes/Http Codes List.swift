import SwiftUI

struct HttpCodesList: View {
    var body: some View {
        List(httpStatusCodes, id: \.code) { code in
            HttpCodeCard(code)
        }
    }
}

#Preview {
    HttpCodesList()
}
