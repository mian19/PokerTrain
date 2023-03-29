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
    var termsButton = UIButton.settingsButton(imageName: "Icon terms of use", title: "Terms of use")
    var supportButton = UIButton.settingsButton(imageName: "Icon support", title: "Support")
    var contactButton = UIButton.settingsButton(imageName: "Icon mail", title: "Contact the developer")
    
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
        view.addSubview(termsButton)
        view.addSubview(supportButton)
        view.addSubview(contactButton)
        
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
        
        termsButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(336)
            make.height.equalTo(56)
            make.top.equalTo(privacyButton.snp.bottom).offset(16)
        }
        supportButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(336)
            make.height.equalTo(56)
            make.top.equalTo(termsButton.snp.bottom).offset(16)
        }
        contactButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(336)
            make.height.equalTo(56)
            make.top.equalTo(supportButton.snp.bottom).offset(16)
        }

    }
    
    private func setActions() {
        privacyButton.addTarget(self, action: #selector(onPrivacyButton), for: .touchUpInside)
     termsButton.addTarget(self, action: #selector(onTermsButton), for: .touchUpInside)
        supportButton.addTarget(self, action: #selector(onSupportButton), for: .touchUpInside)
        contactButton.addTarget(self, action: #selector(onContactButton), for: .touchUpInside)
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
    
    @objc func onTermsButton() {
        showWebView(urlString: "https://onliner.by")
    }
    
    @objc func onSupportButton() {
        showWebView(urlString: "https://onliner.by")
    }
    
    @objc func onContactButton() {
        showWebView(urlString: "https://onliner.by")
    }
    
}
