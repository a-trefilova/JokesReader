
import Foundation

protocol JockesListViewProtocol {
    func setListOfJockes(listOfJockes: [Joke])
}

protocol JockesListPresenterProtocol {
    
    init(service: JockesListService, view: JockesListViewProtocol)
    func presentJockes()
    func getJockes(jokesCount count: Int)
}

class JockesListPresenter: JockesListPresenterProtocol {
    
    private var jockesListService: JockesListService
    private var jockesView: JockesListViewProtocol
    
    required init(service: JockesListService, view: JockesListViewProtocol) {
        self.jockesListService = service
        self.jockesView = view
        
    }
    
    
    func presentJockes() {
//        jockesListService.getJockes(jokesCount: 3) { jokes, error in
//            guard let jokes = jokes else { return}
//            print(jokes)
//            DispatchQueue.main.async {
//                self.jockesView.setListOfJockes(listOfJockes: jokes)
//            }
//        }
    }
    
    func getJockes(jokesCount count: Int)  {
        jockesListService.getJockes(jokesCount: count) { jokes, error in
            guard let jokes = jokes else { return}
            print(jokes)
            DispatchQueue.main.async {
                self.jockesView.setListOfJockes(listOfJockes: jokes)
            }
        }
       
    }
    
    
    
}
