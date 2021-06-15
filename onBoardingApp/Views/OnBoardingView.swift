//
//  onBoardingView.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 15/06/21.
//

import UIKit

class OnBoardingView: UIView {
    
    var currentImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        
        return imageView
    }()
    
    var currentTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .scaleAspectFit
        label.sizeToFit()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        
        return label
    }()
    
    var currentMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 17)
        
        return label
    }()
    
    init(forImage currentImage: String, withTitle currentTitle: String, andMessage currentMessage: String) {
        super.init(frame: .zero)
        self.backgroundColor = .white
        
        if let actualImage = UIImage(named: currentImage) {
            self.currentImage.image = actualImage
        } else {
            self.currentImage.image = UIImage(named: "default")
        }
        
        self.currentTitle.text = currentTitle
        self.currentMessage.text = currentMessage
        
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(currentImage)
        self.addSubview(currentTitle)
        self.addSubview(currentMessage)
        
        NSLayoutConstraint.activate([
            currentImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            currentImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            currentImage.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: 80),
            currentImage.heightAnchor.constraint(equalTo: currentImage.widthAnchor, multiplier: 345/380),
            
            currentTitle.topAnchor.constraint(equalTo: currentImage.bottomAnchor, constant: 60),
            currentTitle.leadingAnchor.constraint(equalTo: currentImage.leadingAnchor),
            currentTitle.trailingAnchor.constraint(equalTo: currentImage.trailingAnchor),
            
            currentMessage.topAnchor.constraint(equalTo: currentTitle.bottomAnchor, constant: 40),
            currentMessage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -150),
            currentMessage.leadingAnchor.constraint(equalTo: currentImage.leadingAnchor),
            currentMessage.trailingAnchor.constraint(equalTo: currentImage.trailingAnchor),
        ])
        
    }
}
