import ScrechKit

struct CountdownView: View {
    @Bindable private var countdown: Countdown
    
    init(_ countdown: Countdown) {
        self.countdown = countdown
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Spacer()
                
                EmojiTextField("Enter emoji", text: $countdown.icon)
                    .onChange(of: countdown.icon) { _, newValue in
                        let filteredValue = newValue.onlyEmoji()
                        
                        countdown.icon = String(filteredValue.reversed().prefix(1))
                    }
                    .frame(width: 50)
                
                Spacer()
            }
            
            TextField("Name", text: $countdown.name)
            
            TextEditor(text: $countdown.note)
                .frame(height: 160)
                .textInputAutocapitalization(.sentences)
                .background(.secondary)
            
            DatePicker("Date", selection: $countdown.deadline)
                .datePickerStyle(.graphical)
        }
        .padding(.horizontal, 5)
    }
}

//#Preview {
//    CountdownView(previewCountdown)
//}
