//
//  OnBoardingModel.swift
//  onBoardingApp
//
//  Created by Jefferson Silva on 15/06/21.
//

import Foundation

class OnBoardingModel {

    init() { }

    let initialPage = 0

    var pagesArray: [OnBoardingVC] = []
    let imagesArray: [String] = ["teste_OB", "teste_OB2", "ALKASKJAS"]

    let titlesArray: [String] = [
        "Você pode fazer isso",
        "Você pode fazer aquilo",
        "Faça agora mesmo!"
    ]

    let messagesArray: [String] = [
        "Lorem ipsum rhoncus cras mattis est porttitor eu phasellus, eu suspendisse ultricies senectus vestibulum.",
        "Lorem ipsum rhoncus cras mattis est porttitor eu phasellus, eu suspendisse ultricies senectus vestibulum.",
        "Lorem ipsum rhoncus cras mattis est porttitor eu phasellus, eu suspendisse ultricies senectus vestibulum."
    ]

}
