//
//  TimerViewController.swift
//  PokerTrain
//
//  Created by Kyzu on 26.03.23.
//

import UIKit

class TimerViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    var elapsedTime: TimeInterval = 6
    var interval = 1.0
        var timer: Timer!
    var isPlaying = false
    var roundButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 133, height: 56)
        button.layer.cornerRadius = 16
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
        button.layer.shadowRadius = 38
        button.layer.shadowOpacity = 0.5
        button.layer.masksToBounds = false
        button.layer.shadowPath = UIBezierPath(roundedRect: button.bounds, cornerRadius: button.layer.cornerRadius).cgPath
        button.setBackgroundImage(UIImage(named: "round"), for: .normal)
        button.backgroundColor = .clear
        
        button.setTitle("Раунд 1", for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 24)
        button.setTitleColor(UIColor.white, for: .normal)
        return  button
    }()
    
    var timerLabel: UILabel = {
        let customFont = UIFont(name: "Raleway-SemiBold", size: 96)
        let label = UILabel()
        label.font = customFont
        label.text = "10:00"
        label.textAlignment = .center
        label.textColor = .mainText
        return label
    }()
    
    var playButton: UIButton = {
        let imageButton = UIButton(type: .custom)
        imageButton.setImage(UIImage(named: "play"), for: .normal)
        return imageButton
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
    
    var blindLabel: UILabel = {
        let customFont = UIFont(name: "Raleway-SemiBold", size: 20.adjW())
        let label = UILabel()
        label.font = customFont
        label.textAlignment = .center
        label.textColor = .mainText
        label.text = "Блайнд"
        return label
    }()
    
    var blindButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 32.adjW())
        button.setTitle("25/50", for: .normal)
        return button
    }()

    var blinds = ["25/50", "50/100", "75/150", "100/200", "125/250", "150/300", "300/600", "600/1200", "750/1500"]
    let myPicker = UIPickerView()
    
    var currentRound = 1
    var currentBlaind = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackground
        setViews()
        setActions()
       
    }
    
    private func setViews() {
        view.addSubview(roundButton)
        view.addSubview(timerLabel)
        view.addSubview(playButton)
        view.addSubview(resetButton)
        view.addSubview(blindLabel)
        view.addSubview(blindButton)
        
        roundButton.snp.makeConstraints { make in
           
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
        }
  
        timerLabel.snp.makeConstraints { make in
            make.width.equalTo(335)
            make.height.equalTo(99)
            make.centerX.equalToSuperview()
            make.top.equalTo(roundButton.snp.bottom).offset(40)
        }
        
        playButton.snp.makeConstraints { make in
            make.width.height.equalTo(80)
            make.centerX.equalToSuperview()
            make.top.equalTo(timerLabel.snp.bottom).offset(VerticalConstants.playToTimer)
        }
        
        resetButton.snp.makeConstraints { make in
            make.width.equalTo(164)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
            make.top.equalTo(playButton.snp.bottom).offset(48)
        }
        
        blindLabel.snp.makeConstraints { make in
            make.width.equalTo(71)
            make.height.equalTo(24)
            make.centerX.equalToSuperview()
            make.top.equalTo(resetButton.snp.bottom).offset(VerticalConstants.verticalSpacing)
        }
        
        blindButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(32)
            make.centerX.equalToSuperview()
            make.top.equalTo(blindLabel.snp.bottom).offset(12)
        }

    }
    
    private func setActions() {
        playButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        blindButton.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
    }
    
    func startTimer() {
        isPlaying = true
        interval = 1.0
        playButton.setImage(UIImage(named: "playpause"), for: .normal)
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            if self?.elapsedTime == 1 {
                if self!.currentRound < 9  {
                    self?.currentRound += 1
                    self?.currentBlaind += 1
                }
                self!.elapsedTime = 6
                DispatchQueue.main.async {
                    self?.roundButton.setTitle("Раунд \(self?.currentRound ?? 1)", for: .normal)
                    if self!.currentBlaind < self!.blinds.count {
                        self!.blindButton.setTitle(self!.blinds[self!.currentBlaind], for: .normal)
                    }
                }
            }
            
            if self!.elapsedTime != 1.0 {
                self?.elapsedTime -= self!.interval
                DispatchQueue.main.async {
                    self?.timerLabel.text = self?.timeString(time: self?.elapsedTime ?? 0)
                }
            }
        }
        }

        func timeString(time: TimeInterval) -> String {
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }

    @objc func playPauseButtonTapped(_ sender: UIButton) {
          if isPlaying {
              pauseTimer()
          } else {
              startTimer()
          }
      }

    @objc func resetButtonTapped(_ sender: UIButton) {
          resetTimer()
      }
    
    @objc func showAlert() {
        let alertController = UIAlertController(title: "Choose an option", message: nil, preferredStyle: .alert)

        // Add actions for each button
        for i in 0...8 {
            let action = UIAlertAction(title: blinds[i], style: .default) { _ in
                // Handle button tap
                self.blindButton.setTitle(self.blinds[i], for: .normal)
                self.currentBlaind = i
            }
            alertController.addAction(action)
        }

        // Add a cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }

      func pauseTimer() {
          timer.invalidate()
          timer = nil
          interval = 0.0
          playButton.setImage(UIImage(named: "play"), for: .normal)
          isPlaying = false
      }

      func resetTimer() {
          if let timer = timer {
              timer.invalidate()
          }
          timerLabel.text = "10:00"
          playButton.setImage(UIImage(named: "play"), for: .normal)
          roundButton.setTitle("Раунд 1", for: .normal)
          isPlaying = false
          elapsedTime = 6
          currentRound = 1
          currentBlaind = 0
          blindButton.setTitle("25/50", for: .normal)

      }


}

private struct VerticalConstants {
    static let playToTimer: CGFloat = UIScreen.main.bounds.height < 755 ? 20 : 48
    static let verticalSpacing: CGFloat = UIScreen.main.bounds.height < 755 ? 30 : 85
    static let verticalHeaderSpacing: CGFloat = 24
}
