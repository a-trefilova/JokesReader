
import Foundation
import Alamofire

class JockesListService {
 
    func getJockes(jokesCount: Int, complition: @escaping ([Joke]?, ErrorType?) -> Void) {
        
        var arrayOfJockes = [Joke]()
        var numberOfIterations = jokesCount
        
        for _ in 1...numberOfIterations {
            AF.request("https://api.icndb.com/jokes/random").responseDecodable(of: Response.self) { response in
                guard let response = response.value
                    else {
                    complition(nil, ErrorType.noConnection)
                    return
                    }
                let joke = response.value
                
                if !arrayOfJockes.contains(where: {$0.id == joke.id}) {
                    let decodedJoke = SymbolCoder().decodeString(input: joke.joke)
                    let newJoke = Joke(id: joke.id, joke: decodedJoke)
                    arrayOfJockes.append(newJoke)
                    complition(arrayOfJockes, nil)
                } else {
                    numberOfIterations += 1
                }
            }
        }
        
    }
    
    
}


enum ErrorType: Error {
    case noConnection
}
