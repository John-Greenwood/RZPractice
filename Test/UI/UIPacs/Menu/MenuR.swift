//
//  MenuR.swift
//  Tutorial
//
//  Created by Александр Сенин on 29.03.2021.
//

import RelizKit

class MenuButtonModel {
    @RZObservable var text: String = ""
    var action = {}
    
    init(text: String){ self.text = text }
}

class MenuR: RZUIPacRouter{
    @RZObservable var isHorizontal = false
    @RZObservable(.ezDamping) var smoke = false
    
    var buttonsModels: [MenuButtonModel] = [
        MenuButtonModel(text: "Button"),
        MenuButtonModel(text: "Button1"),
        MenuButtonModel(text: "Button2")
    ]
    
    //MARK: - API
    //MARK: - ActionsV
    var createPopUp: ()->(UIView) = {UIView()}
    var closePopUp: (UIView)->() = {_ in}
}
