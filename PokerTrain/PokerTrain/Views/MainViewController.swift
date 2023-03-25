//
//  MainViewController.swift
//  52Weeks
//
//  Created by Kyzu on 14.01.23.
//

import UIKit
import WebKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel!
    weak var coordinator: AppCoordinator?
    var firstView: FirstEntranceView!
    var topView: TopMainView!
    var webView: WKWebView!
    var menuViewController: MenuViewController!
    var isMove = false
    var chartPortotype: String = """
    <html>
    <meta name="viewport" content="width=device-width, height= initial-scale=1.0">
    <body bgcolor="#0F131C">
    <!-- TradingView Widget BEGIN -->
    <div class="tradingview-widget-container">
      <div id="tradingview_cf2c9"></div>
      <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
      <script type="text/javascript">
      new TradingView.widget(
      {
      "autosize": true,
      "symbol": "FX_IDC:%symbol%",
      "interval": "%interval%",
      "timezone": "Etc/UTC",
      "theme": "dark",
      "style": "1",
      "locale": "en",
      "toolbar_bg": "#f1f3f6",
      "enable_publishing": false,
      "hide_top_toolbar": true,
     "studies": [
       
      ],
      "save_image": false,
      "container_id": "tradingview_cf2c9"
    }
      );
      </script>
    </div>
    <!-- TradingView Widget END -->
    </body>
    </html>
    """
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setViews()
        updateChart(pair: "EURUSD")
    }
    
    private func setViews() {
        view.backgroundColor = .init(rgb: 0x1C1F2D)
        setTopView()
       setWebView()
    showFirstView()
        loadRequest()
    }
    
    private func setTopView() {
        topView = TopMainView()
        view.addSubview(topView)
        topView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide .topAnchor).isActive = true
        topView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        topView.menuButton.addTarget(self, action: #selector(onMenuButton), for: .touchUpInside)
    }
    
    private func setWebView() {
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        webView.backgroundColor = .init(rgb: 0x1C1F2D)
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        
    }
    
    private func showFirstView() {
        if !UserDefaultsManager.shared.checkResult(.firstEntrance) {
            firstView = FirstEntranceView()
            view.addSubview(firstView)
            firstView.widthAnchor.constraint(equalToConstant: 360.adjW()).isActive = true
            firstView.heightAnchor.constraint(equalToConstant: 400).isActive = true
            firstView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            firstView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            UserDefaultsManager.shared.saveCheck(.firstEntrance)
            firstView.tradeButton.addTarget(self, action: #selector(removeFromMain), for: .touchUpInside)
            firstView.crossButton.addTarget(self, action: #selector(removeFromMain), for: .touchUpInside)
        }
    }
    
    
    func getHtmlForWebView(pair: String) -> String {
        var newHtml = chartPortotype.replacingOccurrences(of: "%interval%", with: "5")
        newHtml = newHtml.replacingOccurrences(of: "%symbol%", with: pair)
        return newHtml
    }
    
    func updateChart(pair: String) {
       webView.loadHTMLString(getHtmlForWebView(pair: pair), baseURL:  nil)
       webView.scrollView.isScrollEnabled = false
    }
    
     func confMenuViewController() {
        if menuViewController == nil {
            menuViewController = MenuViewController()
            view.insertSubview(menuViewController.view, aboveSubview: view)
            addChild(menuViewController)
            menuViewController?.menuButton.addTarget(self, action: #selector(onMenuButton), for: .touchUpInside)
            let width = 0.77 * view.frame.width
            menuViewController.view.frame = CGRect(x: view.frame.minX - width, y: 0, width: width, height: view.frame.height)
        }
    }
    
    private func toggleMenu() {
        confMenuViewController()
        isMove = !isMove
        showMenu(shouldMove: isMove)
    }
    
    private func showMenu(shouldMove: Bool) {
        if shouldMove {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations:  {
                self.menuViewController.view.frame.origin.x = self.view.frame.minX
            }) { (finished) in
                
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations:  {
                let width = 0.77 * self.view.frame.width
                self.menuViewController.view.frame.origin.x = self.view.frame.minX - width
            }) { (finished) in
                
            }
        }
    }
    
    private func loadRequest() {
//        guard let url = URL(string: "https://bionn.space/api/v2/trade?user_id=10054&currency=USDRUB&deal_type=2&deal_value=5000&deal_mode=1") else { return }
//        let queryItems = [URLQueryItem(name: "token", value: "55b9a408-9277-11ed-a1eb-0242ac120002")]
//        
//        var urlComps = URLComponents(string: "https://bionn.space/api/v2/signals?startAt=28.11.2022 10:00&signal=&period=
//")!
//        urlComps.queryItems = queryItems
//        let result = urlComps.url!
//                let urlRequest = URLRequest(url: result)
//        webView.load(urlRequest)
    }
    
    //MARK: - Actions
    
    @objc func removeFromMain() {
        firstView.removeFromSuperview()
    }
    
    @objc func onMenuButton() {
        toggleMenu()
    }
    
    
}
