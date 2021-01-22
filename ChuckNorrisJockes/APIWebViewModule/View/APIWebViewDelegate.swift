
import WebKit

class WkNavDelegate: NSObject, WKNavigationDelegate {
    var url: URL
    var viewController: UIViewController
    var activityIndicator: UIActivityIndicatorView
    
    init(url: URL, viewController: UIViewController, acitivityIndicator: UIActivityIndicatorView) {
        self.url = url
        self.viewController = viewController
        self.activityIndicator = acitivityIndicator
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
            let trust = challenge.protectionSpace.serverTrust!
            let exceptions = SecTrustCopyExceptions(trust)
            SecTrustSetExceptions(trust, exceptions)
            completionHandler(.useCredential, URLCredential(trust: trust))
      
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        activityIndicator.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
}
