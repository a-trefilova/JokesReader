
import Foundation

class SymbolCoder {
    func decodeString(input: String) -> String {
        let string = input
        guard let data = string.data(using: .utf8) else {
            return ""
        }

        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]

        guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) else {
            return ""
        }

        let decodedString = attributedString.string
        return decodedString
    }
}
