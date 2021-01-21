
import UIKit
import WebKit

class APIWebViewController: UIViewController {
    
    var presenter: APIWebViewPresenter!
    private var webView: WKWebView!
    private var webViewDelegate: WkNavDelegate?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "API"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.presentAPI()
    }
    
    private func loadWebView(with url: URL) {
        
        webView.allowsBackForwardNavigationGestures = true
        if !webView.hasOnlySecureContent {
            let alertController = UIAlertController(title: "Unsecure content", message: "We don't trust this site, because it is uncertified. However, you can open it despite its unsafety.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Open anyway", style: .destructive) { _ in
                self.webView.load(URLRequest(url: url))
            }
            let secondAlertAction = UIAlertAction(title: "Don't open this site", style: .cancel, handler: nil)
            alertController.addAction(secondAlertAction)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        } else {
            webView.load(URLRequest(url: url))
        }
    }
}



extension APIWebViewController: APIWebViewViewProtocol {
    func setUrlForWebView(url: URL) {
        loadWebView(with: url)
        webViewDelegate = WkNavDelegate(url: url, viewController: self)
        webView.navigationDelegate = webViewDelegate
    }
    
    func handleErrors(ofType: APIErrorType) {
        switch ofType {
        
        case .noConection:
            let alertController = UIAlertController(title: "No Internet Connection", message: "Please, check your Wi-Fi or wait", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Ok, I'll wait", style: .destructive, handler: nil)
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
        case .unreliableSite:
            break
        }
        
    }
    
    
}
