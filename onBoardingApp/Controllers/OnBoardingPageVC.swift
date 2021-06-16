//
//  OnBoardingPageVC.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 15/06/21.
//

import UIKit

class OnBoardingPageVC: UIPageViewController {

    var model = OnBoardingModel() // Import model.
    var buttonsBottomSpacing = UIScreen.main.bounds.height * -0.05

    var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: .zero)
        pageControl.translatesAutoresizingMaskIntoConstraints = false

        return pageControl
    }()

    var skipButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var nextButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    var nextButtonBottomConstraint: NSLayoutConstraint?
    var skipButtonBottomConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
}

// MARK: - Setup functions.
extension OnBoardingPageVC {
    func setup() {
        dataSource = self
        delegate = self

        // Add actions to buttons.
        pageControl.addTarget(self, action: #selector(pageControlWasTapped), for: .valueChanged)
        skipButton.addTarget(self, action: #selector(skipButtonWasTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonWasTapped), for: .touchUpInside)

        fillPagesArray() // Fills pagesArray.
        setupPageControl()
        setupSkipButton()
        setupNextButton()

        setViewControllers([model.pagesArray[model.initialPage]], direction: .forward, animated: true, completion: nil)
    }

    func setupPageControl() {
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = model.pagesArray.count
        pageControl.currentPage = model.initialPage

        view.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: buttonsBottomSpacing)
        ])
    }

    func setupNextButton() {
        nextButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        nextButton.tintColor = .black
        nextButton.setTitle("Próximo ", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)

        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            nextButton.heightAnchor.constraint(equalToConstant: 20)
        ])

        nextButtonBottomConstraint = nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: buttonsBottomSpacing)
        nextButtonBottomConstraint?.isActive = true
    }

    func setupSkipButton() {
        skipButton.setTitle("Pular :(", for: .normal)
        skipButton.setTitleColor(.black, for: .normal)

        view.addSubview(skipButton)

        NSLayoutConstraint.activate([
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            skipButton.heightAnchor.constraint(equalToConstant: 20)
        ])

        skipButtonBottomConstraint = skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: buttonsBottomSpacing)
        skipButtonBottomConstraint?.isActive = true
    }

    func fillPagesArray() {
        // Checks if arrays are empty and if all arrays have the same size in order to avoid index errors.
        if model.pagesArray.count > 0 && !(model.pagesArray.count == model.titlesArray.count && model.titlesArray.count == model.messagesArray.count) {
            return
        }

        for index in 0..<model.titlesArray.count {
            let newView = OnBoardingView(forImage: model.imagesArray[index], withTitle: model.titlesArray[index], andMessage: model.messagesArray[index])
            let newController = OnBoardingVC()
            newController.view = newView

            model.pagesArray.append(newController)
        }
    }

}

// MARK: - DataSource.
extension OnBoardingPageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = viewController as? OnBoardingVC else { return nil }
        guard let currentIndex = model.pagesArray.firstIndex(of: currentViewController) else { return nil }

        if currentIndex > 0 {
            return model.pagesArray[currentIndex - 1]
        } else {
            return nil
        }

    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = viewController as? OnBoardingVC else { return nil }
        guard let currentIndex = model.pagesArray.firstIndex(of: currentViewController) else { return nil }

        if currentIndex < model.pagesArray.count - 1 {
            return model.pagesArray[currentIndex + 1]
        } else {
            return nil
        }
    }
}

// MARK: - Delegate.
extension OnBoardingPageVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentViewController = viewControllers[0] as? OnBoardingVC else { return }
        guard let currentIndex = model.pagesArray.firstIndex(of: currentViewController) else { return }

        pageControl.currentPage = currentIndex
        if pageControl.currentPage == model.pagesArray.count - 1 || pageControl.currentPage == model.pagesArray.count - 2 {
            animateButtonsBackAndForth()
        }
    }

    private func animateButtonsBackAndForth() {
        let isCurrentPageLast = pageControl.currentPage == model.pagesArray.count - 1

        if isCurrentPageLast {
            skipButtonBottomConstraint?.constant = 80
            nextButtonBottomConstraint?.constant = 80

        } else {
            skipButtonBottomConstraint?.constant = buttonsBottomSpacing
            nextButtonBottomConstraint?.constant = buttonsBottomSpacing
        }

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

// MARK: - Actions.
extension OnBoardingPageVC {
    @objc
    func pageControlWasTapped(_ sender: UIPageControl) {
        setViewControllers([model.pagesArray[sender.currentPage]], direction: .forward, animated: true, completion: nil)

        if sender.currentPage == model.pagesArray.count - 1 || sender.currentPage == model.pagesArray.count - 2 {
            animateButtonsBackAndForth()
        }
    }

    @objc
    func skipButtonWasTapped(sender: UIButton!) {
        let lastPage = model.pagesArray.count - 1
        pageControl.currentPage = lastPage

        setViewControllers([model.pagesArray[lastPage]], direction: .forward, animated: true, completion: nil)
        animateButtonsBackAndForth()
    }

    @objc
    func nextButtonWasTapped(sender: UIButton!) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }

        pageControl.currentPage += 1
        setViewControllers([nextPage], direction: .forward, animated: true, completion: nil)

        if pageControl.currentPage == model.pagesArray.count - 1 || pageControl.currentPage == model.pagesArray.count - 2 {
            animateButtonsBackAndForth()
        }
    }
}
