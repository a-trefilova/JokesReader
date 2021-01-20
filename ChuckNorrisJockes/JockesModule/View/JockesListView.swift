
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
        //button.setTitle("LOAD", for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "LOAD", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.kern: -0.41]), for: .normal)
        //button.setTitleColor(.white, for: .normal)
        
        button.tintColor = .blue
        button.backgroundColor = .blue
        return button
    }()
    
    var buttonBottomConstraintValue: CGFloat = -80
   // var topTFConstraintValue: CGFloat = 350
    
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
        //    topTFConstraintValue = 350 - keyboardHeight
        
//        jokesCountTextField.snp.updateConstraints { (make) in
//            make.top.equalTo(customView.snp.top).offset(topTFConstraintValue)
//        }
        
        loadJokesButton.snp.updateConstraints { (make) in
            make.bottom.equalTo(customView.snp.bottom).offset(buttonBottomConstraintValue)
        }
        
        layoutIfNeeded()
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        buttonBottomConstraintValue = -80
//            topTFConstraintValue = 350
//        jokesCountTextField.snp.updateConstraints { (make) in
//            make.top.equalTo(customView.snp.top).offset(topTFConstraintValue)
//        }
        
        loadJokesButton.snp.updateConstraints { (make) in
            make.bottom.equalTo(customView.snp.bottom).offset(buttonBottomConstraintValue)
        }
        layoutIfNeeded()
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
           // make.top.equalTo(customView.snp.top).offset(topTFConstraintValue)
            make.centerX.equalTo(jokesListTableView.snp.centerX)
            make.height.equalTo(40)
            make.width.equalTo(UIScreen.main.bounds.width / 4)
           // make.bottom.greaterThanOrEqualTo(loadJokesButton.snp.top).offset(-20)
        }
        
        loadJokesButton.snp.makeConstraints { (make) in
            make.top.equalTo(jokesCountTextField.snp.bottom).offset(10)
            make.width.equalTo(UIScreen.main.bounds.width / 5)
            make.centerX.equalTo(jokesListTableView.snp.centerX)
            make.height.equalTo(40)
            make.bottom.equalTo(customView.snp.bottom).offset(buttonBottomConstraintValue)
        }
        
        
    }
    
}


