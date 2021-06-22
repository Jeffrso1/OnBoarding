//
//  OnBoardingModel.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 15/06/21.
//

import Foundation

class OnBoardingModel {

    var currentPage = 0
    let onBoardingItems: [OnBoardingItem] = [
        OnBoardingItem(imageName: "teste_OB", title: "Você pode fazer isso", message: "Lorem ipsum rhoncus cras mattis est porttitor eu phasellus, eu suspendisse ultricies senectus vestibulum."),
        OnBoardingItem(imageName: "teste_OB2", title: "Você pode fazer aquilo", message: "Lorem ipsum rhoncus cras mattis est porttitor eu phasellus, eu suspendisse ultricies senectus vestibulum."),
        OnBoardingItem(imageName: "ALKASKJAS", title: "Faça agora mesmo!", message: "Lorem ipsum rhoncus cras mattis est porttitor eu phasellus, eu suspendisse ultricies senectus vestibulum.")
    ]

}

struct OnBoardingItem {
    var imageName: String
    var title: String
    var message: String
}
