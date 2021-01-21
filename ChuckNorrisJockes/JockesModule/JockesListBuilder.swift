
import UIKit

protocol BuilderProtocol: class {
    func build() -> UIViewController
}

class JockesListBuilder: BuilderProtocol {
    
    func build() -> UIViewController {
        let view = JockesListViewController()
        let presenter = JockesListPresenter(service: JockesListService(), view: view)
        view.presenter = presenter
        
        return view
    }
    
}
