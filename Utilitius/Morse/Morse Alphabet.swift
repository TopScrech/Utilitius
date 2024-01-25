enum MerseRussianAlphabet: String, CaseIterable {
    case А, Б, В, Г, Д, Е, Ё, Ж, З, И, Й, К, Л, М, Н, О, П, Р, С, Т, У, Ф, Х, Ц, Ч, Ш, Щ, Ъ, Ы, Ь, Э, Ю, Я
    
    var morseCode: String {
        switch self {
        case .А: ".-"
        case .Б: "-..."
        case .В: ".--"
        case .Г: "--."
        case .Д: "-.."
        case .Е: "."
        case .Ё: "."
        case .Ж: "...-"
        case .З: "--.."
        case .И: ".."
        case .Й: ".---"
        case .К: "-.-"
        case .Л: ".-.."
        case .М: "--"
        case .Н: "-."
        case .О: "---"
        case .П: ".--."
        case .Р: ".-."
        case .С: "..."
        case .Т: "-"
        case .У: "..-"
        case .Ф: "..-."
        case .Х: "...."
        case .Ц: "-.-."
        case .Ч: "---."
        case .Ш: "----"
        case .Щ: "--.-"
        case .Ъ: "--.--"
        case .Ы: "-.--"
        case .Ь: "-..-"
        case .Э: "..-.."
        case .Ю: "..--"
        case .Я: ".-.-"
        }
    }
}

enum MorseEnglishAlphabet: String, CaseIterable {
    case A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z
    
    var morseCode: String {
        switch self {
        case .A: ".-"
        case .B: "-..."
        case .C: "-.-."
        case .D: "-.."
        case .E: "."
        case .F: "..-."
        case .G: "--."
        case .H: "...."
        case .I: ".."
        case .J: ".---"
        case .K: "-.-"
        case .L: ".-.."
        case .M: "--"
        case .N: "-."
        case .O: "---"
        case .P: ".--."
        case .Q: "--.-"
        case .R: ".-."
        case .S: "..."
        case .T: "-"
        case .U: "..-"
        case .V: "...-"
        case .W: ".--"
        case .X: "-..-"
        case .Y: "-.--"
        case .Z: "--.."
        }
    }
}

enum MorseArabicNumbers: String, CaseIterable {
    case zero = "0", one = "1", two = "2", three = "3", four = "4", five = "5",
         six = "6", seven = "7", eight = "8", nine = "9"
    
    var morseCode: String {
        switch self {
        case .zero: "-----"
        case .one: ".----"
        case .two: "..---"
        case .three: "...--"
        case .four: "....-"
        case .five: "....."
        case .six: "-...."
        case .seven: "--..."
        case .eight: "---.."
        case .nine: "----."
        }
    }
}

enum MorseSpecialCharacters: String, CaseIterable {
    case comma = ",", period = ".", questionMark = "?", space = " ", apostrophe = "'",
         exclamationMark = "!", slash = "/", colon = ":", semicolon = ";",
         equals = "=", plus = "+", minus = "-", underscore = "_",
         doubleQuote = "\"", atSign = "@", dollar = "$"
    
    var morseCode: String {
        switch self {
        case .comma: "--..--"
        case .period: ".-.-.-"
        case .questionMark: "..--.."
        case .space: "/"
        case .apostrophe: ".----."
        case .exclamationMark: "-.-.--"
        case .slash: "-..-."
        case .colon: "---..."
        case .semicolon: "-.-.-."
        case .equals: "-...-"
        case .plus: ".-.-."
        case .minus: "-....-"
        case .underscore: "..--.-"
        case .doubleQuote: ".-..-."
        case .atSign: ".--.-."
        case .dollar: "...-..-"
        }
    }
}
