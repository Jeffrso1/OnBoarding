//
//  OnBoardingVC.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 15/06/21.
//

import UIKit

class OnBoardingItemVC: UIViewController {

    init(item: OnBoardingItem) {
        super.init(nibName: nil, bundle: nil)
        self.view = OnBoardingItemView(for: item)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
