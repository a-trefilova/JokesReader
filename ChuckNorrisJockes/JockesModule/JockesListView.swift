
import UIKit
import SnapKit

class JockesListView: UIView {
    
    private let customView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    var jokesListTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private var jokesCountTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .numberPad
        textField.placeholder = "Input count ..."
        return textField
    }()
    
    var loadJokesButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOAD", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.tintColor = .blue
        button.backgroundColor = .blue
        return button
    }()
    
    var buttonBottomConstraintValue: CGFloat = -80
    var topTFConstraintValue: CGFloat = 350
    
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
    
    func subscribeToShowKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func keyboardWillShow(_ notification: Notification) {
       
            let userInfo = notification.userInfo
            let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
            let keyboardHeight = keyboardSize.cgRectValue.height
            buttonBottomConstraintValue = -80 - keyboardHeight
            topTFConstraintValue = 350 - keyboardHeight
            setNeedsLayout()
            setNeedsUpdateConstraints()
            layoutIfNeeded()
    }

    @objc func keyboardWillHide(_ notification: Notification) {
            buttonBottomConstraintValue = -80
            topTFConstraintValue = 350
    }
    
    
    private func addSubviews() {
        addSubview(customView)
        customView.addSubview(jokesListTableView)
        customView.sendSubviewToBack(jokesListTableView)
        jokesListTableView.addSubview(jokesCountTextField)
        jokesListTableView.addSubview(loadJokesButton)
    }
    
    private func makeConstraints() {
        customView.snp.makeConstraints { (make) in
//            make.top.equalToSuperview()
//            make.leading.equalToSuperview()
//            make.trailing.equalToSuperview()
//            make.bottom.equalToSuperview()
            make.edges.equalToSuperview()
        }
        
        jokesListTableView.snp.makeConstraints { (make) in
            make.top.equalTo(customView.snp.top)
            make.leading.equalTo(customView.snp.leading)
            make.trailing.equalTo(customView.snp.trailing)
            make.bottom.equalTo(customView.snp.bottom)
        }
        
        jokesCountTextField.snp.makeConstraints { (make) in
            make.top.equalTo(jokesListTableView.snp.top).offset(320)
            make.centerX.equalTo(jokesListTableView.snp.centerX)
            make.height.equalTo(30)
            make.bottom.equalTo(loadJokesButton.snp.top).offset(10)
        }
        
        loadJokesButton.snp.makeConstraints { (make) in
            //make.top.equalTo(jokesCountTextField.snp.bottom).offset(10)
            make.centerX.equalTo(jokesListTableView.snp.centerX)
            make.height.equalTo(30)
            make.bottom.equalTo(jokesListTableView.snp.bottom).offset(buttonBottomConstraintValue)
        }
    }
    
}
