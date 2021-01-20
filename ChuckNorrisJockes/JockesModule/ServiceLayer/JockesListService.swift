
import Foundation
import Alamofire

class JockesListService {
 
    func getJockes(jokesCount: Int, complition: @escaping ([Joke]?, ErrorType?) -> Void) {
        
        guard jokesCount > 0  else {
            complition([], ErrorType.zeroResults)
            return
        }
//        let jokesNumber = getCountOfAllJockes()
//        
//        if jokesCount > jokesNumber {
//            complition([], ErrorType.requestLimit)
//        }
        
//        getCountOfAllJockes() { number in
//            if number == 0 {
//                complition([], ErrorType.noConnection)
//            }
//            
//            if number < jokesCount {
//                complition([], ErrorType.requestLimit)
//            }
//        }
        
        
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
                    arrayOfJockes.append(response.value)
                    complition(arrayOfJockes, nil)
                } else {
                    numberOfIterations += 1
                }
            }
        }
        
    }
    
    private func getCountOfAllJockes() -> Int? {
        var value = 0
        AF.request("https://api.icndb.com/jokes/count").responseDecodable(of: CountResponse.self) { response in
            guard let response = response.value else { return }
            guard response.value > 0 else { return }
            DispatchQueue.main.async {
                value = response.value
            }
        }
        if value > 0 {
            return value
        } else {
            return nil
        }
    }
}


enum ErrorType: Error {
    case noConnection
    case requestLimit
    case zeroResults
}
