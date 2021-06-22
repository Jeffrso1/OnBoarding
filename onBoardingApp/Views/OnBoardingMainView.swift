//
//  PageControllerView.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 21/06/21.
//

import UIKit

class OnBoardingMainView: UIView {
    var buttonsBottomSpacing = UIScreen.main.bounds.height * -0.05
    var nextButtonBottomConstraint: NSLayoutConstraint?
    var skipButtonBottomConstraint: NSLayoutConstraint?
    var shouldHide: Bool = false {
        didSet {
            if oldValue != shouldHide {
                shouldHide ? hideView() : showView()
            }
        }
    }

    var pageView: UIView

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

    init(initialPage: Int, numberOfPages: Int, pageView: UIView) {
        self.pageView = pageView

        super.init(frame: .zero)
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = initialPage
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Setup
    func setupPageControl() {
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray

        self.addSubview(pageControl)

        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: self.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        let bottomConstraint = pageControl.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: buttonsBottomSpacing - 30)
        bottomConstraint.priority = UILayoutPriority(750.0)
        bottomConstraint.isActive = true
    }

    func setupNextButton() {
        nextButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        nextButton.tintColor = .black
        nextButton.setTitle("Próximo ", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)

        self.addSubview(nextButton)

        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25),
            nextButton.heightAnchor.constraint(equalToConstant: 20)
        ])

        nextButtonBottomConstraint = nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: buttonsBottomSpacing)
        nextButtonBottomConstraint?.isActive = true
    }

    func setupSkipButton() {
        skipButton.setTitle("Pular :(", for: .normal)
        skipButton.setTitleColor(.black, for: .normal)

        self.addSubview(skipButton)

        NSLayoutConstraint.activate([
            skipButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            skipButton.heightAnchor.constraint(equalToConstant: 20)
        ])

        skipButtonBottomConstraint = skipButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: buttonsBottomSpacing)
        skipButtonBottomConstraint?.isActive = true
    }

    func setupPageView() {
        pageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pageView)

        NSLayoutConstraint.activate([
            pageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            pageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            pageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            pageView.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -10)
        ])
    }

    func setupView() {
        self.backgroundColor = .white

        setupPageControl()
        setupSkipButton()
        setupNextButton()
        setupPageView()
    }
    
// MARK: - Private Functions
    private func hideView() {
        self.skipButtonBottomConstraint?.constant = 80
        self.nextButtonBottomConstraint?.constant = 80

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }

    private func showView() {
        self.skipButtonBottomConstraint?.constant = self.buttonsBottomSpacing
        self.nextButtonBottomConstraint?.constant = self.buttonsBottomSpacing

        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseOut], animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
}
