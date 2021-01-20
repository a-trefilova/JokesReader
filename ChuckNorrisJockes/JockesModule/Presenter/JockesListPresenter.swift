
import Foundation

protocol JockesListViewProtocol {
    func setListOfJockes(listOfJockes: [Joke])
    func reloadView()
    func handleErrors(ofType: ErrorType)
}

protocol JockesListPresenterProtocol {
    
    init(service: JockesListService, view: JockesListViewProtocol)
    func presentJockes()
    func removeJockes()
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
    
    func removeJockes() {
        DispatchQueue.main.async {
            self.jockesView.setListOfJockes(listOfJockes: [])
            self.jockesView.reloadView()
        }
    }
    
    func getJockes(jokesCount count: Int)  {
        jockesListService.getJockes(jokesCount: count) { jokes, error in
            if let error = error {
                self.jockesView.handleErrors(ofType: error)
            }
            guard let jokes = jokes else { return}
            DispatchQueue.main.async {
                self.jockesView.setListOfJockes(listOfJockes: jokes)
                self.jockesView.reloadView()
            }
        }
       
    }
    
    
    
}