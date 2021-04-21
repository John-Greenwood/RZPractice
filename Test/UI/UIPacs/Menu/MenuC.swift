//
//  MenuC.swift
//  Tutorial
//
//  Created by Александр Сенин on 29.03.2021.
//

import RelizKit

class MenuC: RZUIPacController{
    //override var supportedInterfaceOrientations: UIInterfaceOrientationMask {.portrait}
    
    var iPhoneViewType: RZUIPacAnyViewProtocol.Type? {MenuIPhonV.self}
    var iPadViewType: RZUIPacAnyViewProtocol.Type? {MenuIPadV.self}
    var macViewType: RZUIPacAnyViewProtocol.Type? {MenuMacV.self}
    
    var router = MenuR()
    
    func initActions() {
        initButtonsActions(router.buttonsModels)
    }
    
    func open() {
        router.isHorizontal = isHorizontal
    }
    
    func rotate() {
        router.isHorizontal = isHorizontal
    }
    
    private func initButtonsActions(_ models: [MenuButtonModel]){
        for model in models{
            model.action = {[weak self, weak model] in
                self?.buttonsAction(model?.text ?? "")
            }
        }
    }
    
    private func buttonsAction(_ text: String){
        switch text {
        case "Button":
            RZTransition(.Instead, self).uiPacC(ContentC()).archive().animation(.shiftLeft).saveTranslite(false).transit()
        case "Button1":
            let foundation = router.createPopUp()
            let uiPackC = ContentC(.popUp)
            uiPackC.closeClosure = {[weak self, weak foundation] in self?.router.closePopUp(foundation ?? UIView())}
            RZTransition(.In, self).view(foundation).uiPacC(uiPackC).transit()
        case "Button2":
            RZTransition(.Instead, self).uiPacC(ReminderC()).archive().animation(.shiftLeft).transit()
        default: break
        }
    }
}
