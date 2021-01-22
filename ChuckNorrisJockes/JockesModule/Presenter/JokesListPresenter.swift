
import Foundation

protocol JokesListViewProtocol {
    func startLoading()
    func endLoading() 
    func setListOfJokes(listOfJokes: [Joke])
    func reloadView()
    func handleErrors(ofType: ErrorType)
}

protocol JokesListPresenterProtocol {
    init(service: JokesListService, view: JokesListViewProtocol)
    func getJockes(jokesCount count: Int)
}

class JokesListPresenter: JokesListPresenterProtocol {
    
    private var jokesListService: JokesListService
    private var jokesView: JokesListViewProtocol
    
    required init(service: JokesListService, view: JokesListViewProtocol) {
        self.jokesListService = service
        self.jokesView = view
        
    }

    func getJockes(jokesCount count: Int)  {
        jokesView.startLoading()
        jokesListService.getJokes(jokesCount: count) { [weak self] jokes, error in
            if let error = error {
                self?.jokesView.handleErrors(ofType: error)
            }
            guard let jokes = jokes else { return}
            DispatchQueue.main.async {
                self?.jokesView.setListOfJokes(listOfJokes: jokes)
                self?.jokesView.reloadView()
                self?.jokesView.endLoading()
            }
        }
    }
}
