
import Foundation

class APIWebViewModel {
    let url = URL(string: "https://www.icndb.com/api")
}

enum APIErrorType: Error {
    case noConection
}
