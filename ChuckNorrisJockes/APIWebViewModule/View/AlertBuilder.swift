
import UIKit

class AlertBuilder {
    private var title: String
    private var message: String
    private var titleActions: [String]
    
    init(title: String, message: String, titleActions: [String]) {
        self.title = title
        self.message = message
        self.titleActions = titleActions
    }
    
    func getAlertController() -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for item in titleActions {
            let alertAction = UIAlertAction(title: item, style: .destructive, handler: nil)
            alertController.addAction(alertAction)
        }
        
        return alertController
    }
}
