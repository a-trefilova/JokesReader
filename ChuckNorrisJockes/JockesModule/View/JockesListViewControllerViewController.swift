
import UIKit

protocol ViewControllerDelegate: class {
    func selectedCell(row: Int)
}


class JockesListViewController: UIViewController, ViewControllerDelegate {
   
    var presenter: JockesListPresenterProtocol!
    
    var rootView: JockesListView? {
        return view as? JockesListView
    }

    private var rootViewDatasource: JokesListDatasource?
    private var rootViewDelegate: JokesListDelegate?
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
        navigationController?.navigationBar.topItem?.title = "Jokes"
    }

    @objc func loadJokesButtonTapped() {
        //presenter.getJockes(jokesCount: 0)
        rootView?.jokesCountTextField.endEditing(true)
        guard let value = textFieldValue else {
           // UIAlertController
            return
        }
        if 574 >= value {
            presenter.getJockes(jokesCount: value)
        }
    }

    //MARK: View Controller Delegate
    func selectedCell(row: Int) {
        
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
        rootViewDelegate = JokesListDelegate(jokes: listOfJockes)
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
        
        guard let textFieldValue = textFieldValue else { return false}
        if textFieldValue > 574 {
            let alertController = UIAlertController(title: "Request Limit", message: "You've exceeded number of available jockes. Please, enter lower number of jokes", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Understood", style: .destructive, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
        return true 
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
}


