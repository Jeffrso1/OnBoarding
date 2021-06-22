//
//  OnBoardingPageVC.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 15/06/21.
//

import UIKit

class OnBoardingPageVC: UIPageViewController {

    var model = OnBoardingModel() // Import model.
    var pagesArray: [OnBoardingItemVC] = []

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

        fillPagesArray() // Fills pagesArray.

        setViewControllers([pagesArray[model.currentPage]], direction: .forward, animated: true, completion: nil)
    }

    func fillPagesArray() {
        pagesArray = model.onBoardingItems.map { OnBoardingItemVC(item: $0) }
    }

}

// MARK: - DataSource.
extension OnBoardingPageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = viewController as? OnBoardingItemVC else { return nil }
        guard let currentIndex = pagesArray.firstIndex(of: currentViewController) else { return nil }
        
        if currentIndex > 0 {
            return pagesArray[currentIndex - 1]
        } else {
            return nil
        }

    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentViewController = viewController as? OnBoardingItemVC else { return nil }
        guard let currentIndex = pagesArray.firstIndex(of: currentViewController) else { return nil }

        if currentIndex < pagesArray.count - 1 {
            return pagesArray[currentIndex + 1]
        } else {
            return nil
        }
    }
}


