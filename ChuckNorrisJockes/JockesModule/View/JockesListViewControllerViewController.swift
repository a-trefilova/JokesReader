
import UIKit

class JockesListViewController: UIViewController {
    
    var presenter: JockesListPresenterProtocol!
    
    var rootView: JockesListView? {
        return view as? JockesListView
    }

    private var rootViewDatasource: JokesListDatasource?
    private var textFieldValue: Int? {
        didSet {
            print("Textfield value changed")
        }
    }
    
    
    
    override func loadView() {
        view = JockesListView(frame: .zero)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        //presenter.getJockes(jokesCount: 3)
        rootView?.loadJokesButton.addTarget(self, action: #selector(loadJokesButtonTapped), for: .touchUpInside)
    
        rootView?.jokesCountTextField.delegate = self
    }

    @objc func loadJokesButtonTapped() {
        //presenter.getJockes(jokesCount: 0)
        rootView?.jokesCountTextField.endEditing(true)
        guard let value = textFieldValue else {
           // UIAlertController
            return
        }
        
        presenter.getJockes(jokesCount: value)
    }

}

extension JockesListViewController: JockesListViewProtocol {
    func handleErrors(ofType: ErrorType) {
        var alertController: UIAlertController
        switch ofType {
        case .noConnection:
            alertController = UIAlertController(title: "No Internet Connection", message: "Please, check your Wi-Fi or wait", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok, I'll wait", style: .destructive, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        case .requestLimit:
            alertController = UIAlertController(title: "Request Limit", message: "You've exceeded number of available jockes. Please, enter lower number of jokes", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Understood", style: .destructive, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        case .zeroResults:
            alertController = UIAlertController(title: "Zero resuts", message: "We found nothing. Please, enter the number greater than zero", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .destructive, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
   
    
    func setListOfJockes(listOfJockes: [Joke]) {
        rootViewDatasource = JokesListDatasource(jokes: listOfJockes)
        rootView?.jokesListTableView.dataSource = rootViewDatasource
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
        return true 
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}
