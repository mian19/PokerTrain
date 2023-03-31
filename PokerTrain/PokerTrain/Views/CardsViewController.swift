//
//  CardsViewController.swift
//  PokerTrain
//
//

import UIKit

class CardsViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    var titleLabel: UILabel = {
        let customFont = UIFont(name: "Raleway-SemiBold", size: 17)
        let label = UILabel()
        label.font = customFont
        label.text = "Выберите отдельную карту"
        label.textAlignment = .center
        label.textColor = .mainText
        return label
    }()
    
    var completionHandler: ((Int) -> Void)?

    var usedCard = 0
    var doneButton = UIButton.quizButton(title: "Выйти")
    
    var buttonTitles = [""]
    
    var stack1 = UIStackView()
    var stack2 = UIStackView()
    var stack3 = UIStackView()
    var stack4 = UIStackView()
    var stacks: [UIStackView] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBackground
        stacks = [stack1, stack2, stack3, stack4]
        fillStacks()
        //setViews()
        // Do any additional setup after loading the view.
    }
    
    func fillStacks() {
        let numColumns = 4
        for i in 1...52 {
            buttonTitles.append(String(i))
        }
        let numRows = Int(ceil(Double(buttonTitles.count) / Double(numColumns)))

        for i in 0...3 {
            stacks[i].translatesAutoresizingMaskIntoConstraints = false
            stacks[i].axis = .horizontal
            stacks[i].alignment = .fill
            stacks[i].distribution = .fillEqually
            stacks[i].spacing = 6.adjW()
        }
    
        for i in 1...13 {
            let image = UIImage(named: "\(i)") // replace with your own image names
            let button = UIButton()
            button.setImage(image, for: .normal)
            if i == usedCard {
                button.alpha = 0.2
                button.isUserInteractionEnabled = false
            }
                
                button.tag = i
                button.imageView?.contentMode = .scaleAspectFit
                stack1.addArrangedSubview(button)
                button.addTarget(self, action: #selector(self.buttonTapped), for: .touchUpInside)
        }
   
        
        for i in 14...26 {
                    let image = UIImage(named: "\(i)") // replace with your own image names
                    let button = UIButton()
            if i == usedCard {
                button.alpha = 0.2
                button.isUserInteractionEnabled = false
            }
            button.tag = i
                    button.setImage(image, for: .normal)
                    button.imageView?.contentMode = .scaleAspectFit
                    stack2.addArrangedSubview(button)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                }
        
        for i in 27...39 {
                    let image = UIImage(named: "\(i)") // replace with your own image names
                    let button = UIButton()
            if i == usedCard {
                button.alpha = 0.2
                button.isUserInteractionEnabled = false
            }
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                    button.setImage(image, for: .normal)
                    button.imageView?.contentMode = .scaleAspectFit
                    stack3.addArrangedSubview(button)
                }
        
        for i in 40...52 {
                    let image = UIImage(named: "\(i)") // replace with your own image names
                    let button = UIButton()
            if i == usedCard {
                button.alpha = 0.2
                button.isUserInteractionEnabled = false
            }
            button.tag = i
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                    button.setImage(image, for: .normal)
                    button.imageView?.contentMode = .scaleAspectFit
                    stack4.addArrangedSubview(button)
                }
         
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
    }
        
    
     @objc  func buttonTapped(_ sender: UIButton) {
        print(sender.tag)
         let selectedCard: Int = sender.tag
        completionHandler?(selectedCard)
         doneButtonTapped()
    }
    
    @objc func doneButtonTapped() {
        coordinator?.toBack()
    }
    
    func setViews() {
        view.addSubview(titleLabel)
        view.addSubview(stack1)
        view.addSubview(stack2)
        view.addSubview(stack3)
        view.addSubview(stack4)

        view.addSubview(doneButton)
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(28)
        }
        
        let screenWidth = UIScreen.main.bounds.width
        let buttonWidth = (screenWidth - CGFloat(12 * 6.adjW()) - 20) / 13
        let buttonHeight = 1.45 * buttonWidth
        
        stack1.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 20)
            make.height.equalTo(buttonHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(28)
        }
        
        stack2.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 20)
            make.height.equalTo(buttonHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(stack1.snp.bottom).offset(16)
        }
        
        stack3.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 20)
            make.height.equalTo(buttonHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(stack2.snp.bottom).offset(16)
        }
        
        stack4.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width - 20)
            make.height.equalTo(buttonHeight)
            make.centerX.equalToSuperview()
            make.top.equalTo(stack3.snp.bottom).offset(16)
        }
        
        doneButton.snp.makeConstraints { make in
            make.width.equalTo(336)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.top.equalTo(stack4.snp.bottom).offset(280)
        }
    }

}
