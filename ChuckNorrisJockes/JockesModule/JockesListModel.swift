
import Foundation

struct Response: Codable {
    var type: String
    var value: Joke
    
}

struct Joke: Codable {
    let id: Int
    let joke: String
}
