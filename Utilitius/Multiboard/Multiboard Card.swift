import SwiftUI

import SwiftUI

struct MultiboardCard: View {
    @Bindable private var item: MultiboardItem
    
    init(_ item: MultiboardItem) {
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
        }
    }
}

//#Preview {
//    ItemCard()
//}
