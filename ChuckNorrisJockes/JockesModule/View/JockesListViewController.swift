
import UIKit

protocol ViewControllerDelegate: class  {
    
}

class JockesListViewController: UIViewController, ViewControllerDelegate {
   
    var presenter: JockesListPresenterProtocol!
    
    private var rootView: JockesListView? {
        return view as? JockesListView
    }

    private var rootViewDatasource: JokesListDatasource?
    private var rootViewDelegate: JokesListDelegate?
    private var textFieldValue: Int?
    
    override func loadView() {
        view = JockesListView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardByTap()
        rootView?.jokesCountTextField.delegate = self
        rootView?.loadJokesButton.addTarget(self,
                                            action: #selector(loadJokesButtonTapped),
                                            for: .touchUpInside)
        
        navigationController?.navigationBar.topItem?.title = "Jokes"
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

extension JockesListViewController: JockesListViewProtocol {
    func startLoading() {
        rootViewDatasource = JokesListDatasource(jokes: [])
        rootView?.jokesListTableView.dataSource = rootViewDatasource
        rootView?.activityIndicator.startAnimating()
    }
    
    func endLoading() {
        rootView?.activityIndicator.stopAnimating()
    }
    
    func handleErrors(ofType: ErrorType) {
        var alertController: UIAlertController
        switch ofType {
        case .noConnection:
            alertController = UIAlertController(title: "No Internet Connection", message: "Please, check your Wi-Fi or wait", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok, I'll wait", style: .destructive, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func setListOfJockes(listOfJockes: [Joke]) {
        rootViewDatasource = JokesListDatasource(jokes: listOfJockes)
        rootViewDelegate = JokesListDelegate(jokes: listOfJockes, delegate: self)
        rootView?.jokesListTableView.dataSource = rootViewDatasource
        rootView?.jokesListTableView.delegate = rootViewDelegate
        rootView?.jokesListTableView.register(JokesListCell.self, forCellReuseIdentifier: JokesListCell.reuseId)
        rootView?.jokesListTableView.reloadData()
    }
    
    func reloadView() {
        rootView?.jokesListTableView.reloadData()
    }
}

extension JockesListViewController: UITextFieldDelegate {
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            let alertController = UIAlertController(title: "Oops!", message: "Something went wrong...", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok, I'll try again", style: .destructive, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            return false
        }
        textFieldValue = Int(text)
        
        guard let textFieldValue = textFieldValue else {
            return false}
        
        switch textFieldValue {
        
        case 0:
            let alertController = UIAlertController(title: "Zero results", message: "We found nothing. Insert the number greater than zero.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok, I'll try again", style: .destructive, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        case 1...574:
            return true
            
        default:
            let alertController = UIAlertController(title: "Request Limit", message: "Please, enter number of jokes from 0 to 574.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok, I'll try again", style: .destructive, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }

        return false
        
    }
    
}


