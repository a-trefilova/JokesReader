
import WebKit

class WkNavDelegate: NSObject, WKNavigationDelegate {
    var url: URL
    var viewController: UIViewController
    init(url: URL, viewController: UIViewController) {
        self.url = url
        self.viewController = viewController
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
            let trust = challenge.protectionSpace.serverTrust!
            let exceptions = SecTrustCopyExceptions(trust)
            SecTrustSetExceptions(trust, exceptions)
            completionHandler(.useCredential, URLCredential(trust: trust))
      
    }

}
