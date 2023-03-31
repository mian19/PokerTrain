//
//  ChanceViewController.swift
//  PokerTrain
//
//

import UIKit

class ChanceViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    var titleLabel: UILabel = {
        let customFont = UIFont(name: "Raleway-SemiBold", size: 17)
        let label = UILabel()
        label.font = customFont
        label.text = "Вероятность выигрыша"
        label.textAlignment = .center
        label.textColor = .mainText
        return label
    }()
    
    var selected: [Int] = [0]
    
    var percentageLabel: UILabel = {
        let customFont = UIFont(name: "Raleway-SemiBold", size: 32.adjW())
        let label = UILabel()
        label.font = customFont
        label.textAlignment = .center
        label.textColor = .mainText
        label.text = ""
        return label
    }()
    
    var boardLabel: UILabel = {
        let customFont = UIFont(name: "Raleway-Regular", size: 17.adjW())
        let label = UILabel()
        label.font = customFont
        label.textAlignment = .center
        label.textColor = .mainText
        label.text = "Доска"
        return label
    }()
    
    var handsLabel: UILabel = {
        let customFont = UIFont(name: "Raleway-Regular", size: 17.adjW())
        let label = UILabel()
        label.font = customFont
        label.textAlignment = .center
        label.textColor = .mainText
        label.text = "Руки"
        return label
    }()
    
    var resetButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(named: "Duotone"), for: .normal)
        button.setTitle("Сбросить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 15)
        button.frame = CGRect(x: 0, y: 0, width: 164, height: 48)
        button.layer.cornerRadius = 16
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 16
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        button.setBackgroundImage(UIImage(named: "resetButton"), for: .normal)
        button.layer.shadowPath = UIBezierPath(roundedRect: button.bounds, cornerRadius: button.layer.cornerRadius).cgPath
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        return button
    }()
    
    let boardStackView = UIStackView()
    let handsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackground
        setViews()
        setActions()
        // Do any additional setup after loading the view.
    }
    private func setViews() {
        view.addSubview(titleLabel)
        view.addSubview(percentageLabel)
        view.addSubview(boardLabel)
        view.addSubview(boardStackView)
        view.addSubview(handsLabel)
        view.addSubview(handsStackView)
        view.addSubview(resetButton)
        boardStackView.axis = .horizontal
        boardStackView.distribution = .fillEqually
        handsStackView.axis = .horizontal
        handsStackView.distribution = .fillEqually
        for i in 1...5 {
            let imageView = UIImageView(image: UIImage(named: "emptyCard"))
            imageView.contentMode = .scaleAspectFit
            boardStackView.addArrangedSubview(imageView)
        }
        for i in 1...2 {
            let button = UIButton()
            button.setImage(UIImage(named: "emptyCard"), for: .normal)
            button.tag = i
            button.addTarget(self, action: #selector(onCard), for: .touchUpInside)
            handsStackView.addArrangedSubview(button)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(22)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(28)
        }
        
        percentageLabel.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(35)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(48)
        }
        
        boardLabel.snp.makeConstraints { make in
            make.width.equalTo(298)
            make.height.equalTo(25)
            make.centerX.equalToSuperview()
            make.top.equalTo(percentageLabel.snp.bottom).offset(48)
        }
        
        boardStackView.snp.makeConstraints { make in
            make.width.equalTo(298)
            make.height.equalTo(72)
            make.centerX.equalToSuperview()
            make.top.equalTo(boardLabel.snp.bottom).offset(15)
        }
        
        handsLabel.snp.makeConstraints { make in
            make.width.equalTo(298)
            make.height.equalTo(25)
            make.centerX.equalToSuperview()
            make.top.equalTo(boardStackView.snp.bottom).offset(48)
        }
        
        handsStackView.snp.makeConstraints { make in
            make.width.equalTo(112)
            make.height.equalTo(72)
            make.centerX.equalToSuperview()
            make.top.equalTo(handsLabel.snp.bottom).offset(15)
        }
        
        resetButton.snp.makeConstraints { make in
            make.width.equalTo(164)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.top.equalTo(handsStackView.snp.bottom).offset(VerticalConstants.verticalSpacing)
        }
    }
    
    func setActions() {
        resetButton.addTarget(self, action: #selector(onReset), for: .touchUpInside)
    }
    
    @objc func onReset() {
        percentageLabel.text = ""
        boardStackView.subviews.forEach {
            if let imV = $0 as? UIImageView {
                imV.image = UIImage(named: "emptyCard")
            }
        }
        
        handsStackView.subviews.forEach {
            if let imV = $0 as? UIButton {
                imV.setImage(UIImage(named: "emptyCard"), for: .normal)
                imV.isUserInteractionEnabled = true
            }
        }
        
        selected = [0]
    }


    @objc func onCard(_ sender: UIButton) {
        let cards = coordinator?.toCards(selected: selected[0])
        cards!.completionHandler = { [weak self] newData in
            if self?.selected[0] == 0 {
                self?.selected[0] = newData
                print(" this is \(newData) ")
                sender.setImage(UIImage(named: "\(newData)"), for: .normal)
                sender.isUserInteractionEnabled = false
            } else {
                self?.selected.append(newData)
                sender.setImage(UIImage(named: "\(newData)"), for: .normal)
                sender.isUserInteractionEnabled = false
            }
            
            if self?.selected.count == 2 {
                //generate random 5
                let myNumbers = generateRandomNumbersWithoutTwoNumbers((self?.selected[0])!, (self?.selected[1])!)
                
                for i in 0...myNumbers.count - 1 {
                    if let imView = self!.boardStackView.subviews[i] as? UIImageView {
                        imView.image = UIImage(named: "\(myNumbers[i])")
                    }
                }
                
                self!.percentageLabel.text = "\(Int.random(in: 55...95)) %"
            }
        }
        
        func generateRandomNumbersWithoutTwoNumbers(_ firstExcludedNumber: Int, _ secondExcludedNumber: Int) -> [Int] {
            var result = [Int]()
            while result.count < 5 {
                let randomNumber = Int.random(in: 1...52)
                if randomNumber != firstExcludedNumber && randomNumber != secondExcludedNumber {
                    result.append(randomNumber)
                }
            }
            return result
        }
    }
}

private struct VerticalConstants {
    static let verticalSpacing: CGFloat = UIScreen.main.bounds.height < 755 ? 50 : 180
  
}
