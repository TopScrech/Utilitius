import ScrechKit

struct Goida_Memory_View: View {
    private var storage = StorageVM()
    private var memory = MemoryVM()
    
    var body: some View {
        List {
            Section("Storage") {
                ListParam("Total storage", param: storage.total)
                ListParam("Available storage", param: storage.available)
            }
            
            Section("RAM") {
                ListParam("Total RAM", param: formatBytes(memory.totalMemory, countStyle: .memory))
                ListParam("Used RAM", param: formatBytes(memory.usedMemory, countStyle: .memory))
                ListParam("Free RAM", param: formatBytes(memory.freeMemory, countStyle: .memory))
            }
        }
        .navigationTitle("Memory")
    }
}

#Preview {
    Goida_Memory_View()
}
