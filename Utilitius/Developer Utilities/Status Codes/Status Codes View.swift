import SwiftUI

struct StatusCodesView: View {
    @State private var searchField = ""
    @State private var searchRule = ""
    @State private var showSearchField = false
    
    private var filteredHttpStatusCodes: [HTTPStatusCode] {
        guard !searchRule.isEmpty else {
            return httpStatusCodes
        }
        
        return httpStatusCodes.filter {
            String($0.code)
                .contains(searchRule) ||
            
            $0.name
                .lowercased()
                .contains(searchRule.lowercased()) ||
            
            $0.description
                .lowercased()
                .contains(searchRule.lowercased())
        }
    }
    
    var body: some View {
        List {
            if filteredHttpStatusCodes.isEmpty {
                ContentUnavailableView(
                    "Test",
                    systemImage: "pc",
                    description: Text("Test")
                )
                .symbolEffect(.pulse)
            } else {
                ForEach(filteredHttpStatusCodes, id: \.code) { code in
                    StatusCodeCard(code)
                }
            }
            
            if searchRule.isEmpty {
                Section {
                    Text("Powered by [Wikipedia](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes)")
                }
            }
        }
        .navigationTitle("HTTP Status Codes")
        .scrollIndicators(.never)
        .searchable(text: $searchField, isPresented: $showSearchField)
        .onChange(of: searchField) { oldValue, newValue in
            withAnimation {
                searchRule = searchField
            }
        }
        .toolbar {
            Button {
                showSearchField = true
            } label: {
                Image(systemName: "magnifyingglass")
            }
        }
    }
}

#Preview {
    NavigationView {
        StatusCodesView()
    }
}
