
import UIKit
import SnapKit

class JockesListView: UIView {
    
    private let customView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    var jokesListTableView: UITableView = {
        let tableView = UITableView()
        //tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 30
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    var jokesCountTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.placeholder = "Input count ..."
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.adjustsFontSizeToFitWidth = true
        return textField
    }()
    
    var loadJokesButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "LOAD", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.kern: -0.41]), for: .normal)
        button.tintColor = .blue
        button.backgroundColor = #colorLiteral(red: 0.5949049436, green: 0.652549599, blue: 1, alpha: 1)
        return button
    }()
    
    var buttonBottomConstraintValue: CGFloat = -80
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubviews()
        makeConstraints()
        subscribeToShowKeyboardNotifications()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        designTextFieldAndButton()
    }
    
    private func subscribeToShowKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
       
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardHeight = keyboardSize.cgRectValue.height
        buttonBottomConstraintValue = -80 - keyboardHeight
        loadJokesButton.snp.updateConstraints { (make) in
            make.bottom.equalTo(customView.snp.bottom).offset(buttonBottomConstraintValue)
        }
        
        layoutIfNeeded()
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        buttonBottomConstraintValue = -80
        loadJokesButton.snp.updateConstraints { (make) in
            make.bottom.equalTo(customView.snp.bottom).offset(buttonBottomConstraintValue)
        }
        layoutIfNeeded()
    }
    
    
    private func addSubviews() {
        addSubview(customView)
        customView.addSubview(jokesListTableView)
        customView.sendSubviewToBack(jokesListTableView)
        jokesListTableView.addSubview(activityIndicator)
        jokesListTableView.addSubview(jokesCountTextField)
        jokesListTableView.addSubview(loadJokesButton)
    }
    
    private func makeConstraints() {
        customView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        jokesListTableView.snp.makeConstraints { (make) in
            make.top.equalTo(customView.snp.top)
            make.leading.equalTo(customView.snp.leading)
            make.trailing.equalTo(customView.snp.trailing)
            make.bottom.equalTo(customView.snp.bottom)
        }
        
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalTo(customView.snp.centerX)
            make.centerY.equalTo(customView.snp.centerY)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        jokesCountTextField.snp.makeConstraints { (make) in
            make.centerX.equalTo(jokesListTableView.snp.centerX)
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width / 3)
        }
        
        loadJokesButton.snp.makeConstraints { (make) in
            make.top.equalTo(jokesCountTextField.snp.bottom).offset(10)
            make.width.equalTo(UIScreen.main.bounds.width / 5)
            make.centerX.equalTo(jokesListTableView.snp.centerX)
            make.height.equalTo(40)
            make.bottom.equalTo(customView.snp.bottom).offset(buttonBottomConstraintValue)
        }
        
        
    }
    
    private func designTextFieldAndButton() {
        jokesCountTextField.layer.cornerRadius = 8
        jokesCountTextField.layer.borderWidth = 0.25
        jokesCountTextField.layer.borderColor = UIColor(white: 0.5, alpha: 0.3).cgColor
        jokesCountTextField.layer.shadowOpacity = 0.6
        jokesCountTextField.layer.shadowRadius = 8.0
        jokesCountTextField.layer.shadowColor = UIColor.gray.cgColor
        jokesCountTextField.backgroundColor = UIColor.white
        jokesCountTextField.borderStyle = .none
        jokesCountTextField.layer.shadowOffset = CGSize.zero
        
        loadJokesButton.layer.cornerRadius = 8
        loadJokesButton.layer.borderWidth = 0.5
        loadJokesButton.layer.borderColor = #colorLiteral(red: 0.636843056, green: 0.426039911, blue: 0.8565875968, alpha: 1).cgColor
        
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {                jokesCountTextField.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            }
        }
    }
    
}


