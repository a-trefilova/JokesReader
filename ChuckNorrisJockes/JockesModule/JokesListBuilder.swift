
import UIKit

protocol BuilderProtocol: class {
    func build() -> UIViewController
}

class JokesListBuilder: BuilderProtocol {
    
    func build() -> UIViewController {
        let view = JokesListViewController()
        let presenter = JokesListPresenter(service: JokesListService(), view: view)
        view.presenter = presenter
        
        return view
    }
    
}
