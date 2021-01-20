
import Foundation
import Alamofire

class JockesListService {
    
    init() {
       
    }
    
    func getJockes(jokesCount: Int, complition: @escaping ([Joke]?, Error?) -> Void) {
        
        var arrayOfJockes = [Joke]()
        var numberOfIterations = jokesCount
        for number in 1...numberOfIterations {
            AF.request("https://api.icndb.com/jokes/random").responseDecodable(of: Response.self) { response in
                guard let response = response.value
                    else {
                    complition(nil, nil)
                    return
                    }
                let joke = response.value
                if !arrayOfJockes.contains(where: {$0.id == joke.id}) {
                    arrayOfJockes.append(response.value)
                    complition(arrayOfJockes, nil)
                } else {
                    numberOfIterations += 1
                }
       
                
        }
        }
    }
}
