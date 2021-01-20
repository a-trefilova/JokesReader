
import UIKit

protocol JockesListBuilderProtocol: class {
    func build() -> UIViewController
}

class JockesListBuilder: JockesListBuilderProtocol {
    
    
    func build() -> UIViewController {
        let view = JockesListViewController()
        let presenter = JockesListPresenter(service: JockesListService(), view: view)
        view.presenter = presenter
        
        return view
    }
    
    
}
