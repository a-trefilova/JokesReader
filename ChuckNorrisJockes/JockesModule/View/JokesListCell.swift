
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
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        let mainTextLabel = UILabel()
        mainTextLabel.textColor = .black
        mainTextLabel.font =  UIFont.systemFont(ofSize: 20)
        mainTextLabel.textAlignment = .left
        mainTextLabel.lineBreakMode = .byWordWrapping
        mainTextLabel.preferredMaxLayoutWidth = UIScreen.main.bounds.width - 50
        mainTextLabel.numberOfLines = 0 
        mainTextLabel.text = data
        mainTextLabel.adjustsFontSizeToFitWidth = true 
        
        myContentView.addSubview(mainTextLabel)
        mainTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(myContentView.snp.top).offset(14)
            make.leading.equalTo(myContentView.snp.leading).offset(20)
            make.trailing.equalTo(myContentView.snp.trailing)
            make.bottom.equalTo(myContentView.snp.bottom).offset(-14)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.height.equalTo(myContentView.snp.height)
        }
       // contentView.contentHuggingPriority(for: NSLayoutConstraint.Axis.vertical)
        
    }
}
