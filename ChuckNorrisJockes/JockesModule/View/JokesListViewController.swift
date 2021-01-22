
import UIKit

protocol ViewControllerDelegate: class  {
    
}

class JokesListViewController: UIViewController, ViewControllerDelegate {
   
    var presenter: JokesListPresenterProtocol!
    
    private var rootView: JokesListView? {
        return view as? JokesListView
    }

    private var rootViewDatasource: JokesListDatasource?
    private var rootViewDelegate: JokesListDelegate?
    private var textFieldValue: Int?
    
    override func loadView() {
        view = JokesListView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardByTap()
        adaptToDarkMode()
        rootView?.jokesCountTextField.delegate = self
        rootView?.loadJokesButton.addTarget(self,
                                            action: #selector(loadJokesButtonTapped),
                                            for: .touchUpInside)
        navigationController?.navigationBar.topItem?.title = "Jokes"
        
    }

    private func adaptToDarkMode() {
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                navigationController?.navigationBar.tintColor = .white
            }
        }
    }
    
    private func hideKeyboardByTap() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func loadJokesButtonTapped() {
        rootView?.jokesCountTextField.endEditing(true)
        guard let value = textFieldValue else {
            return
        }
        if 574 >= value && value > 0 {
            presenter.getJockes(jokesCount: value)
        }
    }

}

extension JokesListViewController: JokesListViewProtocol {
    func startLoading() {
        rootViewDatasource = JokesListDatasource(jokes: [])
        rootView?.jokesListTableView.dataSource = rootViewDatasource
        rootView?.activityIndicator.startAnimating()
    }
    
    func endLoading() {
        rootView?.activityIndicator.stopAnimating()
    }
    
    func handleErrors(ofType: ErrorType) {
        switch ofType {
        case .noConnection:
            let alertController = AlertBuilder(title: "No Internet Connection",
                                               message: "Please, check your Wi-Fi or wait",
                                               titleActions: ["Ok, I'll wait"])
                .getAlertController()
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func setListOfJokes(listOfJokes: [Joke]) {
        rootViewDatasource = JokesListDatasource(jokes: listOfJokes)
        rootViewDelegate = JokesListDelegate(jokes: listOfJokes, delegate: self)
        rootView?.jokesListTableView.dataSource = rootViewDatasource
        rootView?.jokesListTableView.delegate = rootViewDelegate
        rootView?.jokesListTableView.register(JokesListCell.self, forCellReuseIdentifier: JokesListCell.reuseId)
        rootView?.jokesListTableView.reloadData()
    }
    
    func reloadView() {
        rootView?.jokesListTableView.reloadData()
    }
}

extension JokesListViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            let alertController = AlertBuilder(title: "Oops!",
                                               message: "Something went wrong...",
                                               titleActions: ["Ok, I'll try again"])
                .getAlertController()
            present(alertController, animated: true, completion: nil)
            return false
        }
        textFieldValue = Int(text)
        
        guard let textFieldValue = textFieldValue else {
            return false}
        
        switch textFieldValue {
        
        case 0:
            let alertController = AlertBuilder(title: "Zero results",
                                               message: "We found nothing. Insert the number greater than zero.",
                                               titleActions: ["Ok, I'll try again"])
                .getAlertController()
            present(alertController, animated: true, completion: nil)
        case 1...574:
            return true
            
        default:
            let alertController = AlertBuilder(title: "Request Limit",
                                               message: "Please, enter number of jokes from 0 to 574.",
                                               titleActions: ["Ok, I'll try again"])
                .getAlertController()
            present(alertController, animated: true, completion: nil)
            
        }

        return false
        
    }
    
}


