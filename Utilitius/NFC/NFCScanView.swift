#if !os(macOS)
import SwiftUI
import CoreNFC

struct NFCScanView: View {
    @Environment(NavState.self) private var navState
    @Bindable var readerModel = NFCReaderModel()
    @Bindable var writerModel = NFCWriterModel()
    
    @State private var sheetTagWriter = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                readerModel.startSession()
            } label: {
                VStack(spacing: 16) {
                    Image(systemName: "dot.radiowaves.right")
                        .rotationEffect(.degrees(-90))
                        .foregroundStyle(.green)
                        .symbolEffect(.variableColor)
                        .fontSize(50)
                    
                    Text("Read NFC tag")
                        .foregroundStyle(.white)
                        .title2(.semibold)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 40)
                .background(.ultraThickMaterial, in: .rect(cornerRadius: 32))
            }
            
            Spacer()
            
            Button {
                navState.navigate(.toSavedNfcMessages)
            } label: {
                VStack(spacing: 16) {
                    Image(systemName: "bookmark")
                        .symbolRenderingMode(.multicolor)
                        .fontSize(50)
                    
                    Text("Saved Messages")
                        .foregroundStyle(.white)
                        .title2(.semibold)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 40)
                .background(.ultraThickMaterial, in: .rect(cornerRadius: 32))
            }
            
            Spacer()
            
            Button {
                sheetTagWriter = true
            } label: {
                VStack(spacing: 16) {
                    Image(systemName: "dot.radiowaves.right")
                        .rotationEffect(.degrees(-90))
                        .foregroundStyle(.blue)
                        .symbolEffect(.variableColor.reversing.iterative)
                        .fontSize(50)
                    
                    Text("Write NFC tag")
                        .foregroundStyle(.white)
                        .title2(.semibold)
                }
                .padding(.vertical, 20)
                .padding(.horizontal, 40)
                .background(.ultraThickMaterial, in: .rect(cornerRadius: 32))
            }
            
            Spacer()
        }
        .sheet($readerModel.sheetNFCReader) {
            NFCReaderView()
                .environment(readerModel)
        }
        .sheet($sheetTagWriter) {
            NFCWriterView()
                .environment(writerModel)
        }
        .alert("Error", isPresented: $writerModel.alertError) {
            
        } message: {
            Text(writerModel.alertMessage ?? "")
        }
    }
}

#Preview {
    NFCScanView()
        .environment(NavState())
}

#endif
