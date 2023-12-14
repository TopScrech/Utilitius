import ScrechKit

struct TimerCard: View {
    @Bindable private var countdown: Countdown
    
    init(_ countdown: Countdown) {
        self.countdown = countdown
    }
    
    @State private var currentTime = Date()
    @State private var timer = Timer.publish(
        every: 1,
        on: .main,
        in: .default
    ).autoconnect()
    
    var body: some View {
        HStack {
            Text(countdown.icon)
                .title()
            
            VStack(alignment: .leading) {
                Text(countdown.name)
                
                Text(countdown.deadline, format: Date.FormatStyle(date: .abbreviated, time: .shortened))
                    .foregroundStyle(.tertiary)
                    .footnote()
                
                if let tags = countdown.tags {
                    if !tags.isEmpty {
//                        HStack {
//                            ForEach(tags.prefix(2)) { tag in
//                                HStack(spacing: 0) {
//                                    Image(systemName: "pin.fill")
//                                        .foregroundStyle(.red)
//                                    
//                                    Text(tag.name)
//                                }
//                                .foregroundStyle(.secondary)
//                                .footnote()
//                            }
//                        }
                        
                        HStack {
                            ForEach(tags.dropFirst(2).prefix(2)) { tag in
                                HStack(spacing: 0) {
                                    Image(systemName: "pin.fill")
                                        .foregroundStyle(.red)
                                    
                                    Text(tag.name)
                                }
                                .foregroundStyle(.secondary)
                                .footnote()
                            }
                        }
                    }
                }
            }
            
            Spacer()
            
            Text(timeAgoOrLeft(countdown.deadline))
                .lineLimit(2)
                .frame(width: 90)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 2)
        .foregroundStyle(.foreground)
        .onReceive(timer) { _ in
            currentTime = Date()
        }
    }
    
    func timeAgoOrLeft(_ date: Date) -> AttributedString {
        let now = currentTime
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.maximumUnitCount = 1
        
        let direction: String
        if date > now {
            direction = "left"
        } else {
            direction = "ago"
        }
        
        let timeInterval = date.timeIntervalSince(now)
        let timeString = formatter.string(from: abs(timeInterval))
        let attributes = AttributeContainer ([
            NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .footnote),
            NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel
        ])
        
        let dir = AttributedString (
            direction,
            attributes: attributes
        )
        
        if let timeString {
            return AttributedString(stringLiteral: "\(timeString)\n") + dir
        } else {
            return "Just now"
        }
    }
}
