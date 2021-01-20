
import UIKit
import SnapKit

class JokesListCell: UITableViewCell {
    
    static let reuseId = "JokesListCell"
    
    func fillCellWithData(data: String) {
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        
        
        let myContentView = UIView()
        myContentView.backgroundColor = .white
        myContentView.layer.cornerRadius = 8
        contentView.addSubview(myContentView)
        
        myContentView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom).offset(-15)
        }
        
        let mainTextLabel = UILabel()
        mainTextLabel.textColor = .black
        mainTextLabel.font =  UIFont.systemFont(ofSize: 14)
        mainTextLabel.textAlignment = .left
        mainTextLabel.lineBreakMode = .byWordWrapping
        mainTextLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 50
        mainTextLabel.numberOfLines = 0 
        mainTextLabel.text = data
        
        myContentView.addSubview(mainTextLabel)
        mainTextLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(14)
            make.height.greaterThanOrEqualTo(200)
            make.leading.equalToSuperview().offset(14)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.height.equalTo(myContentView.snp.height)
        }
        contentView.contentHuggingPriority(for: NSLayoutConstraint.Axis.vertical)
        
    }
}
