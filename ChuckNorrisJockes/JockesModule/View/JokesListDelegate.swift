
import UIKit

class JokesListDelegate: NSObject, UITableViewDelegate {
    
    weak var delegate: ViewControllerDelegate?
    var listOfJokes: [Joke]
    init(jokes: [Joke], delegate: ViewControllerDelegate) {
        self.listOfJokes = jokes
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
