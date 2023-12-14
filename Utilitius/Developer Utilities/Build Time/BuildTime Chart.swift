import SwiftUI
import Charts

struct BuildTimeChart: View {
    private let data: [ReviewTime]
    private let color: Color
    
    init(_ data: [ReviewTime], color: Color = .blue) {
        self.data = data
        self.color = color
    }
    
    var body: some View {
        Chart {
            ForEach(data) { data in
                BarMark(
                    x: .value("Month", data.id),
                    y: .value("Time", convertToPoints(data.avg)),
                    width: .fixed(20)
                )
                .foregroundStyle(color)
            }
        }
        .chartYAxis {
            AxisMarks(values: [0, 240, 480, 720, 960]) { value in
                AxisGridLine()
                
                AxisValueLabel("\(customName(value.index))")
            }
        }
//        .chartXAxis {
//            
//        }
    }
    
//    func averageFromAverage() {
//        let avgs = data.map {
//            convertToPoints($0.avg)
//        }
//    }
    
    func customName(_ index: Int) -> String {
        switch index {
        case 0: "Time"
        case 1: "4 hours"
        case 2: "8 hours"
        case 3: "12 hours"
        case 4: "16 hours"
        default: "Mark \(index + 1)"
        }
    }
    
    func convertToPoints(_ timeString: String) -> Double {
        let components = timeString.split(separator: " ")
        var totalMinutes = 0.0
        
        for component in components {
            if component.hasSuffix("h") {
                if let hours = Double(component.dropLast()) {
                    totalMinutes += hours * 60
                }
            } else if component.hasSuffix("m") {
                if let minutes = Double(component.dropLast()) {
                    totalMinutes += minutes
                }
            }
        }
        
        return totalMinutes
    }
}

#Preview {
    List {
        BuildTimeChart([
            ReviewTime(id: 0, month: "May", avg: "13m", max: "7h", min: "13m"),
            ReviewTime(id: 1, month: "May", avg: "13m", max: "7h", min: "13m"),
            ReviewTime(id: 2, month: "May", avg: "3h 13m", max: "7h", min: "13m"),
            ReviewTime(id: 3, month: "May", avg: "1h 3m", max: "7h", min: "13m"),
            ReviewTime(id: 4, month: "May", avg: "6h 13m", max: "7h", min: "13m"),
            ReviewTime(id: 5, month: "May", avg: "1h", max: "7h", min: "13m"),
        ])
        .padding(.top, 5)
    }
}
