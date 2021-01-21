
import UIKit

class JokesListDelegate: NSObject, UITableViewDelegate {
    
    var listOfJokes: [Joke]
    init(jokes: [Joke]) {
        self.listOfJokes = jokes
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
