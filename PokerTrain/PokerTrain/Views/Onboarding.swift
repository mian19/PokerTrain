//
//  Onboarding.swift
//  TraidingSimulator
//
//

import UIKit

class Onboarding: UIPageViewController {

    weak var coordinator: AppCoordinator?
    var pages = [UIViewController]()
    var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "buttonBackground"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 16
        button.clipsToBounds = true
        button.setTitle("Далее", for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-SemiBold", size: 15)
        button.setTitleColor(UIColor.white, for: .normal)
        return  button
    }()
    
    var labelTexts = ["Пройдите обучение\n и выигрывайте", "Быстро организуйте\n игру", "Узнайте шансы\n выигрыша"]
    
    var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont(name: "Raleway-SemiBold", size: 24.adjW())
        return label
    }()
    
    
    var imageView: UIImageView = {
       var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "onboarding1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    let pageControl = UIPageControl()
    let initialPage = 0
    var isRateShowed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        stylePageControl()
        label.text = labelTexts[0]
        layout()
    }

}

extension Onboarding {
    
    func setup() {
        delegate = self

        // create an array of viewController
        for _ in 1...3 {
            let page = OnboardingPage()
            page.view.backgroundColor = UIColor.mainBackground
            pages.append(page)
            
        }

        // set initial viewController to be displayed
        // Note: We are not passing in all the viewControllers here. Only the one to be displayed.
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        nextButton.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        
    }
    
    func stylePageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .init(rgb: 0x734FDA)
        let scale = CGAffineTransform(scaleX: 1.5, y: 1.5)
        pageControl.transform = scale
        pageControl.pageIndicatorTintColor = .init(rgb: 0xffffff, a: 0.4)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    func layout() {
        view.backgroundColor = UIColor.mainBackground
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(label)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 336.adjW()),
            nextButton.heightAnchor.constraint(equalToConstant: 44),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -54),
            nextButton.centerXAnchor.constraint(equalTo: pageControl.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -28),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            label.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -100),
            label.heightAnchor.constraint(equalToConstant: 55),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            imageView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -5.adjW()),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
    }
    
    @objc func onNext() {
        pageControl.currentPage += 1
        imageView.image = UIImage(named: "onboarding\(pageControl.currentPage + 1)")!
        label.text = labelTexts[pageControl.currentPage]
        setViewControllers([pages[pageControl.currentPage]], direction: .forward, animated: true, completion: nil)
        showRate(pageControl.currentPage)
    }

    
    private func showRate(_ lastPage: Int) {
        if lastPage == pages.count - 1 && isRateShowed == false {
           // showRateView()
            isRateShowed = true
            return
        }

        if lastPage == pages.count - 1 && isRateShowed == true {
            print("go To App")
            UserDefaultsManager.shared.saveCheck(.onboarding)
            coordinator?.toMain()
        }
    }
}

// MARK: - Delegates
extension Onboarding: UIPageViewControllerDelegate {
    // How we keep our pageControl in sync with viewControllers
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}

// MARK: - Pages
class OnboardingPage: UIViewController {
}
