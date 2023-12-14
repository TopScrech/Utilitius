import ScrechKit

final class UIEmojiTextField: UITextField {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setEmoji() {
        _ = self.textInputMode
    }
    
    override var textInputContextIdentifier: String? {
        return ""
    }
    
    override var textInputMode: UITextInputMode? {
        for mode in UITextInputMode.activeInputModes {
            if mode.primaryLanguage == "emoji" {
                keyboardType = .default // do not remove
                
                return mode
            }
        }
        return nil
    }
}

struct EmojiTextField: UIViewRepresentable {
    private var placeholder: String = ""
    @Binding private var text: String
    
    init(
        _ placeholder: String,
        text: Binding<String>
    ) {
        self.placeholder = placeholder
        _text = text
    }
    
    func makeUIView(context: Context) -> UIEmojiTextField {
        let emojiTextField = UIEmojiTextField()
        
        emojiTextField.placeholder = placeholder
        emojiTextField.text = text
        emojiTextField.contentHorizontalAlignment = .center
        emojiTextField.font = UIFont.systemFont(ofSize: 40)
        emojiTextField.delegate = context.coordinator
        
        return emojiTextField
    }
    
    func updateUIView(_ uiView: UIEmojiTextField, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    final class Coordinator: NSObject, UITextFieldDelegate {
        private var parent: EmojiTextField
        
        init(parent: EmojiTextField) {
            self.parent = parent
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            main { [weak self] in
                self?.parent.text = textField.text ?? ""
            }
        }
    }
}
