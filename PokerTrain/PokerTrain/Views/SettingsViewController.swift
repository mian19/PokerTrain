//
//  SettingsViewController.swift
//  PokerTrain
//
//  Created by Kyzu on 26.03.23.
//

import UIKit
import WebKit

class SettingsViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    var backButton: UIBarButtonItem!
    
    var titleLabel: UILabel = {
        let customFont = UIFont(name: "Raleway-SemiBold", size: 17)
        let label = UILabel()
        label.font = customFont
        label.text = "Настройки"
        label.textAlignment = .center
        label.textColor = .mainText
        return label
    }()
    var privacyButton = UIButton.settingsButton(imageName: "Icon Privacy policy", title: "Privacy policy")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        view.backgroundColor = UIColor.mainBackground
        setViews()
        setActions()
    }
    
    private func setViews() {
        
        view.addSubview(titleLabel)
        view.addSubview(privacyButton)
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(125)
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(28)
        }
        
        privacyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(336)
            make.height.equalTo(56)
            make.top.equalTo(titleLabel.snp.bottom).offset(41)
        }

    }
    
    private func setActions() {
        privacyButton.addTarget(self, action: #selector(onPrivacyButton), for: .touchUpInside)
    }
    
    private func showWebView(urlString: String) {
        let vc = WebViewController()
        vc.urlString = urlString
        DispatchQueue.main.async {            
            vc.start()
        }
        present(vc, animated: true, completion: nil)
       
    }
    
    @objc func onPrivacyButton() {
        showWebView(urlString: "https://onliner.by")
    }
    
}
