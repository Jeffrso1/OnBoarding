//
//  onBoardingView.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 15/06/21.
//

import UIKit

class OnBoardingView: UIView {

    var stackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40

        return stackView
    }()

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
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)

        return label
    }()

    var currentMessage: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
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
        stackView.addArrangedSubview(currentImage)
        stackView.addArrangedSubview(currentTitle)
        stackView.addArrangedSubview(currentMessage)

        stackView.setCustomSpacing(60, after: currentImage)

        self.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            currentImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            currentImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            currentImage.heightAnchor.constraint(equalTo: currentImage.widthAnchor, multiplier: 345/380),

            currentTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            currentTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30),

            currentMessage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50),
            currentMessage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50)
        ])
    }
}
