import Foundation

@Observable
final class XcodesVM {
    var xcodes: [XcodesResponse] = []
    
    var sortedAndFilteredXcodes: [XcodesResponse] {
        if selectedVersion != "All" {
            xcodes.filter { xcodeResponse in
                let number = xcodeResponse.version.number.split(separator: ".").first ?? ""
                let selectedNumber = selectedVersion//.split(separator: ".").first ?? ""
                return number == selectedNumber
            }
        } else {
            xcodes
        }
    }
    
    var selectedVersion = "All"
    var versions: [String] {
        Array(
            Set(
                xcodes.compactMap {
                    $0.version.number.split(separator: ".")
                        .first
                        .map(String.init)
                }
            )
        )
        .compactMap { Int($0) }
        .sorted()
        .reversed()
        .map { String($0) }
    }
    
    var averageDaysBetweenReleases: Double? {
        guard sortedAndFilteredXcodes.count > 1 else { return nil }
        
        var totalDays = 0
        for index in 0..<sortedAndFilteredXcodes.count - 1 {
            if let currentDate = sortedAndFilteredXcodes[index].date.date, let nextDate = sortedAndFilteredXcodes[index + 1].date.date {
                let daysDifference = Calendar.current.dateComponents([.day], from: nextDate, to: currentDate).day ?? 0
                totalDays += daysDifference
            }
        }
        
        return Double(totalDays) / Double(sortedAndFilteredXcodes.count - 1)
    }
    
    func fetch() {
        let url = URL(string: "https://xcodereleases.com/data.json")!
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let decoder = JSONDecoder()
                let value = try decoder.decode([XcodesResponse].self, from: data!)
                self.xcodes = value
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func download() {
        if let fileURL = Bundle.main.url(forResource: "XcodesJSON", withExtension: "txt") {
            if let iCloudFolderURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents") {
                let destinationURL = iCloudFolderURL.appendingPathComponent(fileURL.lastPathComponent)
                
                do {
                    try FileManager.default.startDownloadingUbiquitousItem(at: iCloudFolderURL)
                    try FileManager.default.copyItem(at: fileURL, to: destinationURL)
                    print("File copied to iCloud folder")
                } catch let error {
                    print("Error copying file: \(error.localizedDescription)")
                }
            } else {
                // iCloud is not set up, saving to downloads directory
                let downloadsURL = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first
                let destinationURL = downloadsURL?.appendingPathComponent(fileURL.lastPathComponent)
                
                do {
                    try FileManager.default.copyItem(at: fileURL, to: destinationURL!)
                    print("File copied to downloads folder")
                } catch let error {
                    print("Error copying file to downloads folder: \(error.localizedDescription)")
                }
            }
        } else {
            print("File not found in bundle")
        }
    }
}
