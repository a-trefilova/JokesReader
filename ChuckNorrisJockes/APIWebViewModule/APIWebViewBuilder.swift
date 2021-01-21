
import UIKit

class APIWebViewBuilder: BuilderProtocol {
    
    func build() -> UIViewController {
        let model = APIWebViewModel()
        let view = APIWebViewController()
        let presenter = APIWebViewPresenter(model: model, view: view)
        view.presenter = presenter
        return view
    }
    
}
