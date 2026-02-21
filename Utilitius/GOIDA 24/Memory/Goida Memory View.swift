import ScrechKit

struct Goida_Memory_View: View {
    private var storage = StorageVM()
    private var memory = MemoryVM()
    
    var body: some View {
        List {
            Section("Storage") {
                LabeledContent("Total storage", value: storage.total)
                LabeledContent("Available storage", value: storage.available)
            }
            
            Section("RAM") {
                LabeledContent("Total RAM", value: formatBytes(memory.totalMemory, countStyle: .memory))
                LabeledContent("Used RAM", value: formatBytes(memory.usedMemory, countStyle: .memory))
                LabeledContent("Free RAM", value: formatBytes(memory.freeMemory, countStyle: .memory))
            }
        }
        .navigationTitle("Memory")
    }
}

#Preview {
    Goida_Memory_View()
}
