
import Foundation

protocol APIWebViewViewProtocol {
    func setUrlForWebView(url: URL)
    func handleErrors(ofType: APIErrorType)
}

protocol APIWebViewPresenterProtocol {
    
    init(model: APIWebViewModel, view: APIWebViewViewProtocol)
    func presentAPI()
    
}

class APIWebViewPresenter: APIWebViewPresenterProtocol {
    var model: APIWebViewModel
    var view: APIWebViewViewProtocol
    
    required init(model: APIWebViewModel, view: APIWebViewViewProtocol) {
        self.model = model
        self.view = view
    }
    
    func presentAPI() {
        guard let url = model.url else {
            view.handleErrors(ofType: APIErrorType.noConection)
            return }
        
        view.setUrlForWebView(url: url)
    }
    
    
}
