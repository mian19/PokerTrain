//
//  LearnViewController.swift
//  PokerTrain
//
//  Created by Kyzu on 26.03.23.
//

import UIKit
import SnapKit

class LearnViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    var titleLabel: UILabel = {
        let customFont = UIFont(name: "Raleway-SemiBold", size: 17)
        let label = UILabel()
        label.font = customFont
        label.text = "Обучение"
        label.textAlignment = .center
        label.textColor = .mainText
        return label
    }()

    var mainButton = UIButton.learnButton(imageName: "mainIco", title: "Основы")
    var collectionButton = UIButton.learnButton(imageName: "collection", title: "Комбинации\nкарт", numberLines: 2)
    var tacticButton = UIButton.learnButton(imageName: "tactic", title: "Тактика")
    var blefButton = UIButton.learnButton(imageName: "blef", title: "Блеф")
    var bankrollButton = UIButton.learnButton(imageName: "mainIco", title: "Банкрол", big: true)
    var examButton = UIButton.learnButton(imageName: "exam", title: "Экзамен" , big: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackground
        setViews()
        setActions()
    }
    
    private func setViews() {
        view.addSubview(titleLabel)
        view.addSubview(mainButton)
        view.addSubview(collectionButton)
        view.addSubview(tacticButton)
        view.addSubview(blefButton)
        view.addSubview(bankrollButton)
        view.addSubview(examButton)
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(125)
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(28)
        }
        
        mainButton.snp.makeConstraints { make in
            make.right.equalTo(view.snp.centerX).offset(-6)
            make.width.equalTo(162)
            make.height.equalTo(68)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        collectionButton.snp.makeConstraints { make in
            make.left.equalTo(view.snp.centerX).offset(6)
            make.width.equalTo(162)
            make.height.equalTo(68)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
        
        tacticButton.snp.makeConstraints { make in
            make.right.equalTo(view.snp.centerX).offset(-6)
            make.width.equalTo(162)
            make.height.equalTo(68)
            make.top.equalTo(mainButton.snp.bottom).offset(16)
        }
        
        blefButton.snp.makeConstraints { make in
            make.left.equalTo(view.snp.centerX).offset(6)
            make.width.equalTo(162)
            make.height.equalTo(68)
            make.top.equalTo(mainButton.snp.bottom).offset(16)
        }
        
        bankrollButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(336)
            make.height.equalTo(68)
            make.top.equalTo(blefButton.snp.bottom).offset(16)
        }
        
        examButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(336)
            make.height.equalTo(68)
            make.top.equalTo(bankrollButton.snp.bottom).offset(16)
        }
    }
    
    private func setActions() {
        blefButton.addTarget(self, action: #selector(onBlefButton), for: .touchUpInside)
    }
    
    @objc func onBlefButton() {
        coordinator?.toReader(topic: .blef)
    }

}
