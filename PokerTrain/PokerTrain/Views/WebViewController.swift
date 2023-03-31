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

    let webBack: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "webBack"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return button
    }()
    
    let webForward: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "webForward"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return button
    }()
    
    let webReload: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "webReload"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        return button
    }()
    
    var isShowNav = false
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        webBack.addTarget(self, action: #selector(onWebBack), for: .touchUpInside)
        webForward.addTarget(self, action: #selector(onWebForward), for: .touchUpInside)
        webReload.addTarget(self, action: #selector(onWebReload), for: .touchUpInside)
        
        stackView.addArrangedSubview(webBack)
        stackView.addArrangedSubview(webForward)
        stackView.addArrangedSubview(webReload)
    
                stackView.axis = .horizontal
                stackView.distribution = .equalCentering
                stackView.alignment = .fill
               // stackView.spacing = 10

       

    }
    
    @objc func onWebBack() {
        webView.goBack()
    }
    
    @objc func onWebForward() {
        webView.goForward()
    }
    
    @objc func onWebReload() {
        webView.reload()
    }
    
    func start() {
        
        if isShowNav {
            if !UserDefaultsManager.shared.checkResult(.firstEntrance) {
                showRateView()
                UserDefaultsManager.shared.saveCheck(.firstEntrance)
            }
            
            
            view.addSubview(stackView)
            stackView.translatesAutoresizingMaskIntoConstraints = false
                   stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
                   stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
                   stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        }
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

