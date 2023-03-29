//
//  TimerViewController.swift
//  PokerTrain
//
//  Created by Kyzu on 26.03.23.
//

import UIKit

class TimerViewController: UIViewController {

    weak var coordinator: AppCoordinator?
    var elapsedTime: TimeInterval = 0
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
        let customFont = UIFont(name: "Raleway-SemiBold", size: 96.adjW())
        let label = UILabel()
        label.font = customFont
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
        return button
    }()
    
    var blindLabel: UILabel = {
        let customFont = UIFont(name: "Raleway-SemiBold", size: 96.adjW())
        let label = UILabel()
        label.font = customFont
        label.textAlignment = .center
        label.textColor = .mainText
        return label
    }()
    
    var blindButton: UIButton = {
       let button = UIButton()
        return button
    }()


    var currentRound = 1
    var currentBlaind = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackground
        setViews()
        setActions()
        startTimer()
        // Do any additional setup after loading the view.
    }
    
    private func setViews() {
        
    }
    
    private func setActions() {
        
    }
    
    func startTimer() {
            timer = Timer.scheduledTimer(withTimeInterval: 600, repeats: true) { [weak self] timer in
                if self?.elapsedTime == 600 {
                    if self!.currentRound < 9 {
                        self?.currentRound += 1
                        self?.currentBlaind += 1
                    }
                    self?.elapsedTime = 0
                }
                self?.elapsedTime += 1.0
                
                self?.timerLabel.text = self?.timeString(time: self?.elapsedTime ?? 0)
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

    

      func pauseTimer() {
          timer.invalidate()
          playPauseButton.setTitle("Play", for: .normal)
          isPlaying = false
      }

      func resetTimer() {
          timer.invalidate()
          count = 0.0
          timerLabel.text = "0.0"
          playPauseButton.setTitle("Play", for: .normal)
          isPlaying = false
      }

}
