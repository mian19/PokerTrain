//
//  TimerViewController.swift
//  PokerTrain
//
//  Created by Kyzu on 26.03.23.
//

import UIKit

class TimerViewController: UIViewController {

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
