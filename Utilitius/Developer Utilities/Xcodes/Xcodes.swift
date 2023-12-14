import ScrechKit

struct Xcodes_View: View {
    @Bindable private var model = XcodesVM()
    
    @AppStorage("showReleaseDate") private var showReleaseDate = false
    @AppStorage("showMinimumMacos") private var showMinimumMacOS = false
    @AppStorage("showSwiftVersion") private var showSwiftVersion = false
    @AppStorage("showSDKBuildNumber") private var showSDKBuildNumber = false
    
    @AppStorage("showSDKiOS") private var showSDKiOS = false
    @AppStorage("showSDKmacOS") private var showSDKmacOS = false
    @AppStorage("showSDKwatchOS") private var showSDKwatchOS = false
    @AppStorage("showSDKtvOS") private var showSDKtvOS = false
    @AppStorage("showSDKvisionOS") private var showSDKvisionOS = false
    
    @State private var sheetBackup = false
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Additional Info") {
                    Toggle("Release Date", isOn: $showReleaseDate.animation())
                    Toggle("Minimum macOS", isOn: $showMinimumMacOS.animation())
                    Toggle("Swift version", isOn: $showSwiftVersion.animation())
                    Toggle("SKD Build Number", isOn: $showSDKBuildNumber.animation())
                }
                
                DisclosureGroup("SDK") {
                    Toggle("iOS", isOn: $showSDKiOS.animation())
                    Toggle("macOS", isOn: $showSDKmacOS.animation())
                    Toggle("watchOS", isOn: $showSDKwatchOS.animation())
                    Toggle("tvOS", isOn: $showSDKtvOS.animation())
                    Toggle("visionOS", isOn: $showSDKvisionOS.animation())
                }
                
                Picker("Xcode Version", selection: $model.selectedVersion) {
                    Text("All")
                        .tag("All")
                    
                    ForEach(model.versions, id: \.self) { version in
                        Text(version)
                            .tag(version)
                    }
                }
                .pickerStyle(.navigationLink)
            }
            
            if let averageDays = model.averageDaysBetweenReleases {
                let days = String(format: "%.1f", averageDays)
                let version = model.selectedVersion == "All" ? "all" : "Xcode \(model.selectedVersion)"
                
                HStack {
                    Text("Average days between **\(version)** releases: **\(days)**")
                        .foregroundStyle(.tertiary)
                }
                .footnote()
            }
            
            ForEach(model.sortedAndFilteredXcodes.indices, id: \.self) { index in
                let xcode = model.sortedAndFilteredXcodes[index]
                let name = xcode.name
                let version = xcode.version.number
                let betaNumber = xcode.version.release.beta?.description ?? ""
                
                var beta: String {
                    if xcode.version.release.release != nil {
                        ""
                    } else {
                        "Beta"
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("\(name) \(version) \(beta) \(betaNumber)")
                        .foregroundStyle(xcode.version.release.release != nil ? .primary : .secondary)
                    
                    if showMinimumMacOS {
                        Text("macOS \(xcode.requires)")
                            .footnote()
                            .foregroundStyle(.orange)
                    }
                    
                    if let releaseDate = xcode.date.date {
                        if showReleaseDate {
                            Text(releaseDate.formatted(date: .abbreviated, time: .omitted))
                                .foregroundStyle(.secondary)
                                .footnote()
                        }
                        
                        if index < model.sortedAndFilteredXcodes.count - 1, let previousDate = model.sortedAndFilteredXcodes[index + 1].date.date {
                            let daysDifference = Calendar.current.dateComponents([.day], from: previousDate, to: releaseDate).day
                            
                            if let daysDiff = daysDifference {
                                Text("\(daysDiff) days \(index == 0 ? "since previous release" : "s.p.r")")
                                    .footnote()
                                    .foregroundStyle(.tertiary)
                            }
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Group {
                                if showSwiftVersion {
                                    if let swift = xcode.compilers?.swift?.first {
                                        Text("Swift \(swift.number ?? "")")
                                    }
                                }
                                
                                if showSDKiOS,
                                   let version = xcode.sdks?.iOS?.first?.number {
                                    let build = showSDKBuildNumber ? (xcode.sdks?.iOS?.first?.build ?? "") : ""
                                    Text("**iOS \(version)** *\(build)*")
                                }
                                
                                if showSDKmacOS, let version = xcode.sdks?.macOS?.first?.number {
                                    let build = showSDKBuildNumber ? (xcode.sdks?.macOS?.first?.build ?? "") : ""
                                    Text("**macOS \(version)** *\(build)*")
                                }
                                
                                if showSDKwatchOS, let version = xcode.sdks?.watchOS?.first?.number {
                                    let build = showSDKBuildNumber ? (xcode.sdks?.watchOS?.first?.build ?? "") : ""
                                    Text("**watchOS \(version)** *\(build)*")
                                }
                                
                                if showSDKtvOS, let version = xcode.sdks?.tvOS?.first?.number {
                                    let build = showSDKBuildNumber ? (xcode.sdks?.tvOS?.first?.build ?? "") : ""
                                    Text("**tvOS \(version)** *\(build)*")
                                }
                                
                                if showSDKvisionOS, let version = xcode.sdks?.visionOS?.first?.number {
                                    let build = showSDKBuildNumber ? (xcode.sdks?.visionOS?.first?.build ?? "") : ""
                                    Text("**visionOS \(version)** *\(build)*")
                                }
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(.blue, in: .capsule)
                        }
                        .footnote()
                        .foregroundStyle(.white)
                        .animation(.easeInOut, value: showSwiftVersion)
                    }
                }
                .contextMenu {
                    Menu("Links") {
                        if let link = xcode.links?.download?.url {
                            Button("Download") {
                                openURL(link)
                            }
                        }
                        
                        if let link = xcode.links?.download?.url {
                            MenuButton("Notes", icon: "") {
                                openURL(link)
                            }
                        }
                    }
                }
            }
            
            Section {
                Text("Powered by [xcodereleases](https://xcodereleases.com)")
                
                Text("""
All downloads are hosted by Apple.
Links in this app take you directly to Apple’s download pages.
This is not an official Apple service.
""")
                Button("Backup Data") {
                    sheetBackup = true
                }
            }
        }
        .navigationTitle("Xcodes")
        .sheet(isPresented: $sheetBackup) {
            NavigationView {
                if let url = Bundle.main.url(forResource: "XcodesJSON", withExtension: "txt") {
                    QuickLookView(url)
                        .navigationTitle("XcodesJSON.txt")
                        .toolbarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .topBarLeading) {
                                Button("Close", role: .destructive) {
                                    sheetBackup = false
                                }
                            }
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Download") {
                                    model.download()
                                }
                            }
                        }
                }
            }
        }
        .task {
            model.fetch()
        }
        .refreshable {
            model.fetch()
        }
    }
}

#Preview {
    NavigationView {
        Xcodes_View()
    }
}
