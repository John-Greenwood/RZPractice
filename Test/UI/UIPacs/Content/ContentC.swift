//
//  ContentC.swift
//  Tutorial
//
//  Created by Александр Сенин on 29.03.2021.
//

import RelizKit

enum ContentType {
    case screen
    case popUp
}

class ContentC: RZUIPacController{
    
    var iPhoneViewType: RZUIPacAnyViewProtocol.Type? {pacType == .screen ? ContentIPhoneVScreen.self : ContentMacVPopUp.self}
    var iPadViewType:   RZUIPacAnyViewProtocol.Type? {pacType == .screen ? ContentIPadVScreen.self   : ContentMacVPopUp.self}
    var macViewType:    RZUIPacAnyViewProtocol.Type? {pacType == .screen ? ContentMacVScreen.self    : ContentMacVPopUp.self}
    
    var router = ContentR()
    
    var pacType: ContentType = .screen
    var closeClosure = {}
    
    func initActions() {
        router.closeButtonAction = {[weak self] in self?.closeButtonAction()}
    }
    
    func open() {
        router.isHorizontal = isHorizontal
    }

    
    func rotate() {
        router.isHorizontal = isHorizontal
    }
    
    private func closeButtonAction(){
        if pacType == .screen{
            RZTransition(.Instead, self).back().animation(.ezAnimR).transit()
        }else{
            closeClosure()
        }
    }
    
    func didCreated() {
        
    }
    
    init(_ pacType: ContentType = .screen){
        super.init(nibName: nil, bundle: nil)
        self.pacType = pacType
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
