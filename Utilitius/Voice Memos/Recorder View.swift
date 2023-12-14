import ScrechKit

struct RecorderView: View {
    private var vm = RecorderVM()
    
    var body: some View {
        VStack {
            if let buttonText = vm.buttonText {
                Button(buttonText) {
                    vm.recordTapped()
                }
            }
            
            List {
                ForEach(vm.recordedFiles, id: \.id) { recordedFile in
                    Button {
                        vm.playRecording(recordedFile.name)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(recordedFile.name)
                            
                            if let date = recordedFile.creationDate {
                                Text("Created: \(date)")
                            }
                            
                            if let length = recordedFile.length {
                                Text("Length: \(String(format: "%.1f", length)) seconds")
                            }
                            
                            if let size = recordedFile.size {
                                Text("Size: \(formatBytes(size, countStyle: .file))")
                            }
                        }
                    }
                    .foregroundStyle(.foreground)
                }
                .onDelete(perform: vm.deleteRecording)
            }
        }
        .refreshable {
            vm.updateRecordedFiles()
        }
    }
}

#Preview {
    RecorderView()
}
