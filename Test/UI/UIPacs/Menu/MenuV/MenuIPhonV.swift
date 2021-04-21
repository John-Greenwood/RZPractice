//
//  MenuV.swift
//  Tutorial
//
//  Created by Александр Сенин on 29.03.2021.
//

import RelizKit

class MenuIPhonV: RZUIPacView{
    var router: MenuR!
    
    var buttonsSpace: RZProtoValue {router.isHorizontal ? 2 % self*.h : 2 % self*.w}
    var popUpFoundationWidth: RZProtoValue {router.isHorizontal ? 80 % self*.h : 80 % self*.w}
    
    var buttons = [UIButton]()
    var testView = UIView()
    var buttonsFoundation = UIView()
    var smoke = UIView()
    
    func initActions() {
        router.createPopUp = {[weak self] in self?.createPopUp() ?? UIView()}
        router.closePopUp = {[weak self] in self?.closePopUp($0)}
        
        
    }
    
    
    
    func create() {
        createSelf()
        createButtons()
        createButtonsFoundation()
        createSmoke()
        
        
    }
    
    private func createSelf(){
        self+>.color(.a3_8_9D)
    }
    
    //MARK: - Buttons
    private func createButtons(){
        var maxY: RZProtoValue = 0*
        
        for model in router.buttonsModels{
            let button = createButton(model.text)+>.y(maxY).addAction {[weak model] in model?.action()}.view
            
            buttonsFoundation.addSubview(button)
            buttons.append(button)
            
            maxY = button|*.mY + buttonsSpace
        }
    }
    
    private func createButton(_ text: String) -> UIButton{
        UIButton()+>
            .text(text)
            .template(.textButton(.b1, .color(), .font(), .size()))
            .view
    }
    
    //MARK: - Buttons Foundation
    private func createButtonsFoundation(){
        guard let button = buttons.last else {return}
        
        self.addSubview(buttonsFoundation)
        buttonsFoundation+>.width(button*.w).height(button*.mY).x(self|*.scX, .center).y(self|*.scY, .center)
    }
    
    private func createSmoke(){
        self.addSubview(smoke)
        smoke+>
            .color(UIColor.c9ED.withAlphaComponent(0.6))
            .width(0.5* * (50 % self|*.w)).height(self|*.h)
            .x(self|*.scX, .right)
            .template(router.$smoke.switcher([
                true: .custom{ $0+>.isHidden(false).alpha(1) },
                false: .custom{[weak self] smoke, completion in
                    smoke+>.alpha(0)
                    completion{ if self?.router.smoke == false { smoke+>.isHidden(true) } }
                }
            ]))
    }
    
    private func createPopUp() -> UIView{
        router.smoke = true
        
        let popUpFoundation = UIView()+>
            .width(popUpFoundationWidth).height(popUpFoundationWidth)
            .x(self|*.scX, .center).y(self|*.scY, .center)
            .tx(self|*.w)
            .view
        
        RZUIAnimation.ezDamping.animate {
            popUpFoundation+>.tx(0*)
        }
        
        addSubview(popUpFoundation)
        
        return popUpFoundation
    }
    
    private func closePopUp(_ view: UIView){
        router.smoke = false
        
        RZUIAnimation.ezDamping.animate ({
            view+>.tx(self|*.w)
        },{_ in
            view.removeFromSuperview()
        })
    }
}
