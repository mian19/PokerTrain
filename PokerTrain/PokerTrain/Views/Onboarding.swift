//
//  Onboarding.swift
//  TraidingSimulator
//
//  Created by Kyzu on 11.02.23.
//

import UIKit

class Onboarding: UIPageViewController {

    weak var coordinator: AppCoordinator?
    var pages = [UIViewController]()
    var nextButton = UIButton.roundedButton(imageName: "NextButton", side: 56.adjW())
    let pageControl = UIPageControl()
    let initialPage = 0
    var isRateShowed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        stylePageControl()
        layout()
    }

}

extension Onboarding {
    
    func setup() {
        delegate = self

        // create an array of viewController
        for i in 1...4 {
            let page = OnboardingPage()
            page.view.layer.contents = UIImage(named: "onboarding\(i)")!.cgImage
            pages.append(page)
        }

        // set initial viewController to be displayed
        // Note: We are not passing in all the viewControllers here. Only the one to be displayed.
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        nextButton.addTarget(self, action: #selector(onNext), for: .touchUpInside)
        
    }
    
    func stylePageControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .init(rgb: 0xffffff)
        pageControl.pageIndicatorTintColor = .init(rgb: 0xCAD2EC, a: 0.3)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
    }
    
    func layout() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -152),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 56.adjW()),
            nextButton.heightAnchor.constraint(equalTo: nextButton.widthAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
            nextButton.centerXAnchor.constraint(equalTo: pageControl.centerXAnchor)
        ])
    }
    
    @objc func onNext() {
        pageControl.currentPage += 1
        setViewControllers([pages[pageControl.currentPage]], direction: .forward, animated: true, completion: nil)
        showRate(pageControl.currentPage)
    }
    
    private func showRate(_ lastPage: Int) {
        if lastPage == pages.count - 1 && isRateShowed == false {
            showRateView()
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
