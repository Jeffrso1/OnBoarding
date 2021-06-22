//
//  OnBoardingMainVC.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 21/06/21.
//

import UIKit

class OnBoardingMainVC: UIViewController {

    let model: OnBoardingModel
    let pageVC: OnBoardingPageVC
    let onBoardingView: OnBoardingMainView

    init(model: OnBoardingModel) {
        self.model = model
        self.pageVC = OnBoardingPageVC(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.onBoardingView = OnBoardingMainView(initialPage: model.currentPage, numberOfPages: model.onBoardingItems.count, pageView: pageVC.view)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        self.view = onBoardingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pageVC.delegate = self
        setupButtonAction()
        // Do any additional setup after loading the view.
    }

    func setupButtonAction() {
        // Add actions to buttons.
        onBoardingView.pageControl.addTarget(self, action: #selector(pageControlWasTapped), for: .valueChanged)
        onBoardingView.skipButton.addTarget(self, action: #selector(skipButtonWasTapped), for: .touchUpInside)
        onBoardingView.nextButton.addTarget(self, action: #selector(nextButtonWasTapped), for: .touchUpInside)
    }
}
// MARK: - Actions.
extension OnBoardingMainVC {
    @objc
    func pageControlWasTapped(_ sender: UIPageControl) {
        pageVC.setViewControllers([pageVC.pagesArray[sender.currentPage]], direction: .forward, animated: true, completion: nil)

        animateButtonsBackAndForth()
    }

    @objc
    func skipButtonWasTapped(sender: UIButton!) {
        let lastPage = pageVC.pagesArray.count - 1
        onBoardingView.pageControl.currentPage = lastPage

        pageVC.setViewControllers([pageVC.pagesArray[lastPage]], direction: .forward, animated: true, completion: nil)
        animateButtonsBackAndForth()
    }

    @objc
    func nextButtonWasTapped(sender: UIButton!) {
        guard let currentPage = pageVC.viewControllers?[0] else { return }
        guard let nextPage = pageVC.dataSource?.pageViewController(pageVC, viewControllerAfter: currentPage) else { return }

        onBoardingView.pageControl.currentPage += 1
        pageVC.setViewControllers([nextPage], direction: .forward, animated: true, completion: nil)

        animateButtonsBackAndForth()
    }
}
// MARK: - Delegate.
extension OnBoardingMainVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentViewController = viewControllers[0] as? OnBoardingItemVC else { return }
        guard let currentIndex = pageVC.pagesArray.firstIndex(of: currentViewController) else { return }

        onBoardingView.pageControl.currentPage = currentIndex
        animateButtonsBackAndForth()
    }

    func animateButtonsBackAndForth() {
        let isCurrentPageLast = onBoardingView.pageControl.currentPage == pageVC.pagesArray.count - 1
        onBoardingView.shouldHide = isCurrentPageLast
    }
}
