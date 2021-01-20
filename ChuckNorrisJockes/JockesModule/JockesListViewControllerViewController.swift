
import UIKit

class JockesListViewController: UIViewController {
    
    var presenter: JockesListPresenterProtocol!
    
    var rootView: JockesListView? {
        return view as? JockesListView
    }

    private var rootViewDatasource: JokesListDatasource?
    
    override func loadView() {
        view = JockesListView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        presenter.getJockes(jokesCount: 3)
       
        view.layoutIfNeeded()
        //jokesCountTextField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }

    

    
    //buttonTapped () {
    // presenter.loadJockes(number: Number)
    //  }
    
    
}

extension JockesListViewController: JockesListViewProtocol {
    func setListOfJockes(listOfJockes: [Joke]) {
        rootViewDatasource = JokesListDatasource(jokes: listOfJockes)
        rootView?.jokesListTableView.dataSource = rootViewDatasource
        rootView?.jokesListTableView.register(JokesListCell.self, forCellReuseIdentifier: JokesListCell.reuseId)
        rootView?.jokesListTableView.reloadData()
    }
}
