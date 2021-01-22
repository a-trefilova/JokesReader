
import UIKit
import WebKit
import SnapKit

class APIWebViewController: UIViewController {
    
    var presenter: APIWebViewPresenter!
    private var webView: WKWebView!
    private var webViewDelegate: WkNavDelegate?
    
    private var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true 
        return indicator
    }()

    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutActivityIndicator()
        navigationController?.navigationBar.topItem?.title = "API"
        if #available(iOS 12.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                navigationController?.navigationBar.tintColor = .white
            }
        }
        presenter.presentAPI()
    }
    
    private func layoutActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        view.bringSubviewToFront(activityIndicator)
    }
    
    private func loadWebView(with url: URL) {
        
        webView.allowsBackForwardNavigationGestures = true
        if !webView.hasOnlySecureContent {
            let alertController = UIAlertController(title: "Unsecure content", message: "We don't trust this site, because it is uncertified. However, you can open it despite its unsafety.", preferredStyle: .alert)
            let firstAction = UIAlertAction(title: "Open anyway", style: .destructive) {[weak self] _ in
                self?.activityIndicator.startAnimating()
                self?.webView.load(URLRequest(url: url))
                self?.activityIndicator.stopAnimating()
            }
            let secondAction = UIAlertAction(title: "Don't open this site", style: .cancel, handler: nil)
            alertController.addAction(secondAction)
            alertController.addAction(firstAction)
            present(alertController, animated: true, completion: nil)
        } else {
            webView.load(URLRequest(url: url))
        }
    }
}



extension APIWebViewController: APIWebViewViewProtocol {
    func setUrlForWebView(url: URL) {
        loadWebView(with: url)
        webViewDelegate = WkNavDelegate(url: url, viewController: self, acitivityIndicator: activityIndicator)
        webView.navigationDelegate = webViewDelegate
    }
    
    func handleErrors(ofType: APIErrorType) {
        switch ofType {
        case .noConection:
            let alertController = AlertBuilder(title: "No Internet Connection",
                                               message: "Please, check your Wi-Fi or wait",
                                               titleActions: ["Ok, I'll wait"])
                .getAlertController()
            present(alertController, animated: true, completion: nil)
        }
    }
}



