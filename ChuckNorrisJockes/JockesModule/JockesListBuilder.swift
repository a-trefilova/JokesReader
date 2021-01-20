
import UIKit
//protocol UserProgrammsBuilderProtocol: class {
//    func build() -> UIViewController
//}
//
//class UserProgrammsBuilder: UserProgrammsBuilderProtocol {
//
//    var model: UserProgrammsModel
//    init(model: UserProgrammsModel) {
//        self.model = model
//    }
//
//
//    func build() -> UIViewController {
//
//        let view = UserProgrammsViewController()
//        let presenter = UserProgrammsPresenter(model: model, view: view)
//        view.presenter = presenter
//
//        return view
//
//
//    }
//
//}

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
