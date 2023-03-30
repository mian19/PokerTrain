//
//  ViewController.swift
//  webtest
//
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var urlString: String? = nil
    let loader = UIActivityIndicatorView()
    let protectionSpace = URLProtectionSpace(host: "example.com", port: 0, protocol: "http", realm: nil, authenticationMethod: NSURLAuthenticationMethodHTTPBasic)

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        if !UserDefaultsManager.shared.checkResult(.firstEntrance) {
            showRateView()
            UserDefaultsManager.shared.saveCheck(.firstEntrance)
        }
        let credential = URLCredentialStorage.shared.defaultCredential(for: protectionSpace)

              let userContentController = WKUserContentController()
              let script = "document.getElementById('username').value = '\(credential?.user ?? "")';document.getElementById('password').value = '\(credential?.password ?? "")';"
              let userScript = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
              userContentController.addUserScript(userScript)

              let configuration = WKWebViewConfiguration()
              configuration.userContentController = userContentController
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), configuration: configuration)
    
        view.addSubview(webView)
        webView.navigationDelegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    func start() {
        let url = URL(string: urlString!)!
        let request = URLRequest(url: url)
        webView.load(request)
        
        loader.style = .large
              loader.center = view.center
              view.addSubview(loader)

              loader.startAnimating()
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
         loader.startAnimating()
     }

     func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
         loader.stopAnimating()
     }
    
}

