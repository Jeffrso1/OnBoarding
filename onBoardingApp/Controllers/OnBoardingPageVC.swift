//
//  OnBoardingPageVC.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 15/06/21.
//

import UIKit

class OnBoardingPageVC: UIPageViewController {
    
    var model = OnBoardingModel() // Import model.
    
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
        
        return button
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
        
    }
    
}

// MARK: - Setup functions.
extension OnBoardingPageVC {
    func setup(){
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
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
        ])
    }
    
    func setupNextButton() {
        nextButton.setTitle("Próximo", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        
        view.addSubview(nextButton)
        
        NSLayoutConstraint.activate([
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setupSkipButton() {
        skipButton.setTitle("Pular", for: .normal)
        skipButton.setTitleColor(.black, for: .normal)
        
        view.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            skipButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            skipButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func fillPagesArray() {
        // Checks if arrays are empty and if all arrays have the same size in order to avoid index errors.
        if model.pagesArray.count > 0 && !(model.pagesArray.count == model.titlesArray.count && model.titlesArray.count == model.messagesArray.count){
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
        guard let currentIndex = model.pagesArray.firstIndex(of: viewController as! OnBoardingVC) else { return nil }
        
        if currentIndex > 0 {
            return model.pagesArray[currentIndex - 1]
        } else {
            return nil
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = model.pagesArray.firstIndex(of: viewController as! OnBoardingVC) else { return nil }
        
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
        guard let currentIndex = model.pagesArray.firstIndex(of: viewControllers[0] as! OnBoardingVC) else { return }
        
        pageControl.currentPage = currentIndex
    }
}

// MARK: - Actions.
extension OnBoardingPageVC {
    @objc
    func pageControlWasTapped(_ sender: UIPageControl) {
        setViewControllers([model.pagesArray[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc
    func skipButtonWasTapped(sender: UIButton!) {
        let lastPage = model.pagesArray.count - 1
        pageControl.currentPage = lastPage
        
        setViewControllers([model.pagesArray[lastPage]], direction: .forward, animated: true, completion: nil)
    }
    
    @objc
    func nextButtonWasTapped(sender: UIButton!) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        pageControl.currentPage += 1
        setViewControllers([nextPage], direction: .forward, animated: true, completion: nil)
        
    }
    
}
