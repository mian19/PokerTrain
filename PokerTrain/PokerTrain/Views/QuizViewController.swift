//
//  QuizViewController.swift
//  PokerTrain
//
//

import UIKit

class QuizViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    var counter = 0
    var currentQuiz = 0
    var questions: [Quiz]!
    var doneButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 17)
        button.backgroundColor = .clear
        return button
    }()
    
    let answersStackView: UIStackView = {
    let stackView = UIStackView()
        stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .equalSpacing
        return stackView
    }()

    var button1 = UIButton.quizButton(title: "")
    var button2 = UIButton.quizButton(title: "")
    var button3 = UIButton.quizButton(title: "")
    
    var titleLabel: UILabel = {
        let customFont = UIFont(name: "Raleway-SemiBold", size: 20)
        let label = UILabel()
        label.font = customFont
        label.numberOfLines = 2
        label.text = "Какая комбинация изображена на картинке?"
        label.textAlignment = .left
        label.textColor = .mainText
        return label
    }()
    
    var imageView: UIImageView = {
        let imView = UIImageView()
        imView.backgroundColor = .clear
        return imView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackground
        setViews()
        doneButton.addTarget(self, action: #selector(onDoneButton), for: .touchUpInside)
        start()
    }
    
    private func setViews() {
        view.addSubview(doneButton)
        view.addSubview(titleLabel)
        view .addSubview(imageView)
        view.addSubview(answersStackView)
        answersStackView.addArrangedSubview(button1)
        answersStackView.addArrangedSubview(button2)
        answersStackView.addArrangedSubview(button3)
        doneButton.snp.makeConstraints { make in
            make.width.equalTo(66)
            make.height.equalTo(22)
            make.right.equalToSuperview().offset(-9)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leftMargin.rightMargin.equalToSuperview().offset(16)
            make.height.equalTo(48)
            make.top.equalTo(doneButton.snp.bottom).offset(14)
        }
        
        imageView.snp.makeConstraints { make in
            make.leftMargin.equalToSuperview().offset(20)
            make.rightMargin.equalToSuperview().offset(-20)
            make.height.equalTo(196)
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
        }
        
        answersStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(180)
            make.width.equalTo(336)
            make.top.equalTo(imageView.snp.bottom).offset(32)
        }
        
    }
    
    func start() {
        imageView.image = UIImage(named: "\(questions[currentQuiz].imageName)q")
        for i in 0...questions[currentQuiz].answers.count - 1 {
            if let button = answersStackView.subviews[i] as? UIButton {
                button.setTitle(questions[currentQuiz].answers[i], for: .normal)
                button.addTarget(self, action: #selector(answer), for: .touchUpInside)
            }
            
        }
    }
    
    @objc func answer(_ sender: UIButton) {
        if currentQuiz < questions.count {
            if let title = sender.title(for: .normal), title == questions[currentQuiz].rightAnswer {
                counter += 1
            }
            currentQuiz += 1
            if currentQuiz < questions.count {
                start()
            }
            }
         
        if currentQuiz == questions.count, counter == questions.count {
                hideAll()
            imageView.image = UIImage(named: "succes")
            
            } else if currentQuiz == questions.count, counter != questions.count{
                hideAll()
                imageView.image = UIImage(named: "loh")
            }

    }
    
    func hideAll() {
        answersStackView.isHidden = true
        doneButton.isHidden = true
        titleLabel.isHidden = true
        imageView.snp.updateConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(-30)
            make.height.equalTo(412)
        }
        
        let backButton = UIButton.quizButton(title: "Выйти")
        view.addSubview(backButton)
        backButton.bringSubviewToFront(view)
        backButton.addTarget(self, action: #selector(onDoneButton), for: .touchUpInside)
        backButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(44)
            make.width.equalTo(336)
            make.top.equalTo(imageView.snp.bottom).offset(50)
        }
        
    }
    
    @objc func onDoneButton() {
        coordinator?.toBack()
    }
 

}
