import SwiftUI

struct CalculatorButtonModel {
    let label: String
    let action: () -> Void
    
    init(_ label: String, action: @escaping () -> Void) {
        self.label = label
        self.action = action
    }
}

let calculatorButtons: [[CalculatorButtonModel]] = [
    [
        .init("7") {
            
        },
        
            .init("8") {
                
            },
        
            .init("8") {
                
            }
    ],
    [
        .init("4") {
            
        },
        
            .init("5") {
                
            },
        
            .init("6") {
                
            }
    ],
    [
        .init("1") {
            
        },
        
            .init("2") {
                
            },
        
            .init("3") {
                
            }
    ],
    [
        .init("-") {
            
        },
        
            .init("0") {
                
            },
        
            .init("-") {
                
            }
    ]
]

struct CalculatorView: View {
    var body: some View {
        VStack {
            ForEach(0..<calculatorButtons.count, id: \.self) { row in
                HStack {
                    ForEach(0..<calculatorButtons[row].count, id: \.self) { button in
//                        Text(button.description)
                    }
                }
            }
        }
    }
}

struct CalculatorButton: View {
    private let label: String
    
    init(_ label: String) {
        self.label = label
    }
    
    var body: some View {
        Button {
            
        } label: {
            Text(label)
        }
    }
}

#Preview {
    CalculatorView()
}
