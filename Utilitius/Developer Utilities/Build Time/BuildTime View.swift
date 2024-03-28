import SwiftUI
import SwiftSoup

struct BuildTimeView: View {
    private var vm = BuildTimeVM()
    
    var body: some View {
        List {
            if let buildTime = vm.buildTime {
                Section {
                    BuildTimeCard("Build Processing",
                                  value: buildTime.buildProcessing)
                }
                
                Section("Test Flight") {
                    BuildTimeCard("In Beta Review",
                                  value: buildTime.inBetaReview
                    )
                    
                    BuildTimeCard("Waiting for Beta Review",
                                  value: buildTime.waitingForBetaReview
                    )
                }
                
                Section("In Review") {
                    BuildTimeChart(buildTime.waitingForReview)
                }
                .padding(.top)
                
                Section("Waiting for Review") {
                    BuildTimeChart(buildTime.inReview)
                }
                .padding(.top)
                
                BuildTimeCard("Updated",
                              value: buildTime.updated
                )
            }
            
            Text("Powered by [Runway](https://www.runway.team/appreviewtimes)")
        }
        .navigationTitle("Review Time")
        .scrollIndicators(.never)
        .refreshableTask {
            vm.fetch()
        }
    }
}

struct ReviewTimeData {
    let waitingForReview: [ReviewTime]
    let inReview: [ReviewTime]
    let waitingForBetaReview: String
    let inBetaReview: String
    let buildProcessing: String
    let updated: String
}

struct ReviewTime: Identifiable {
    let id: Int
    let month: String
    let avg: String
    let max: String
    let min: String
}

#Preview("Review Time") {
    NavigationView {
        BuildTimeView()
    }
}
