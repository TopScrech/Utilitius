import Foundation
import Observation
import SwiftSoup

@Observable
final class BuildTimeVM {
    var buildTime: ReviewTimeData?
    
    func fetch() {
        fetchHtml { result in
            switch result {
            case .success(let model):
                do {
                    self.buildTime = try self.extractBuildTimes(model)
                } catch {
                    print("error extractBuildTimes")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchHtml(completion: @escaping (Result<String, Error>) -> Void) {
        let url = URL(string: "https://runway.team/appreviewtimes")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error {
                completion(.failure(error))
                return
            }
            
            if let data, let htmlString = String(data: data, encoding: .utf8) {
                completion(.success(htmlString))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to decode HTML"])))
            }
        }.resume()
    }
    
    func extractBuildTimes(_ html: String) throws -> ReviewTimeData {
        let document = try SwiftSoup.parse(html)
        let tooltips = try document.select(".tooltip.barvalue")
        
        var buildTimes: [ReviewTime] = []
        
        var idCounter = 0
        for tooltip in tooltips {
            let month = try tooltip.select(".tooltip-text.date").text()
            let avg = try tooltip.select(".div-block-15 .tooltip-text.stat").eq(0).text()
            let max = try tooltip.select(".div-block-15 .tooltip-text.stat").eq(1).text()
            let min = try tooltip.select(".div-block-15 .tooltip-text.stat").eq(2).text()
            
            buildTimes.append(
                ReviewTime(
                    id: idCounter,
                    month: month,
                    avg: avg,
                    max: max,
                    min: min
                )
            )
            
            if idCounter == 5 {
                idCounter = 0
            } else {
                idCounter += 1
            }
        }
        
        let waitingForBetaReviewDiv = try document.select("div.art-module-small-nested").first()
        let waitingForBetaReviewValue = try waitingForBetaReviewDiv?.select("div.art-module-stat-small").text() ?? ""
        
        let inBetaReviewDiv = try document.select("div.art-module-small-nested").get(1)
        let inBetaReviewValue = try inBetaReviewDiv.select("div.art-module-stat-small").text()
        
        let buildProcessingDiv = try document.select("div.art-module-small").first
        let buildProcessingValue = try buildProcessingDiv?.select("div.art-module-stat-small").text() ?? ""
        
        let dateElement = try document.select("div.art-timestamp div.date").first()
        let dateValue = try dateElement?.text() ?? ""
        
        let timeElement = try document.select("div.art-timestamp div.time").first()
        let timeValue = try timeElement?.text() ?? ""
        
        let updated = "\(dateValue) \(timeValue)"
        
        let waitingForReviewTimes = Array(buildTimes.prefix(6))
        let intReviewTimes = Array(buildTimes.suffix(6))
        
        return ReviewTimeData(
            waitingForReview: waitingForReviewTimes,
            inReview: intReviewTimes,
            waitingForBetaReview: waitingForBetaReviewValue,
            inBetaReview: inBetaReviewValue,
            buildProcessing: buildProcessingValue,
            updated: updated
        )
    }
}
