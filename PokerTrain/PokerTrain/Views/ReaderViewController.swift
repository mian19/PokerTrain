//
//  ReaderViewController.swift
//  PokerTrain
//
//

import UIKit
import SnapKit

class ReaderViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    var article: String!
    var titleText: String!
    
    var doneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 17)
        button.backgroundColor = .clear
        return button
    }()
    
    var titleLabel: UILabel = {
        let customFont = UIFont(name: "Raleway-SemiBold", size: 32)
        let label = UILabel()
        label.font = customFont
        //label.text = "Обучение"
        label.textAlignment = .center
        label.textColor = .mainText
        return label
    }()
    var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable  = false
        textView.font = UIFont(name: "Raleway-Regular", size: 17)
        textView.textColor = .mainText
        textView.backgroundColor = .clear
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackground
        setViews()
        titleLabel.text = titleText
        textView.text = article
        
        doneButton.addTarget(self, action: #selector(onDoneButton), for: .touchUpInside)

     
    }
    
    private func setViews() {
        view.addSubview(doneButton)
        view.addSubview(titleLabel)
        view.addSubview(textView)
        doneButton.snp.makeConstraints { make in
            make.width.equalTo(66)
            make.height.equalTo(22)
            make.right.equalToSuperview().offset(-9)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leftMargin.rightMargin.equalToSuperview().offset(16)
            make.height.equalTo(31)
            make.top.equalTo(doneButton.snp.bottom).offset(14)
        }
        
        textView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
    }

    @objc func onDoneButton() {
        coordinator?.toBack()
    }

}
