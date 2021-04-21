//
//  ReminderR.swift
//  Test
//
//  Created by John Greenwood on 20.04.2021.
//

import RelizKit

class DayButtonModel {
    @RZObservable var text = ""
    @RZObservable(.ezDamping) var isSelected = false
    var action = {}
    var day = 1
    init(_ text: String){ self.text = text }
}

class ReminderR: RZUIPacRouter {
    
    var titleText      = "Когда напомнить\nвам о практике?"
    var skipButtonText = "Пропустить"
    var quoteText      = "\"Завтрашний успех - каждодневный труд\""
    var quoteAutorText = "- Девраха Пржнанпрад, мудрец"
    var planbuttonText = "СПЛАНИРОВАТЬ"
    
    var primaryColor   = #colorLiteral(red: 0.6676632762, green: 0.4251080155, blue: 0.976035893, alpha: 1)
    var secondaryColor = #colorLiteral(red: 0.9464746118, green: 0.8950688243, blue: 0.974467814, alpha: 1)
    
    var selectedTime   = Date()
    
    @RZObservable var buttonModels: [DayButtonModel] = []
    
    var skipButtonAction = {}
    var planButtonAction = {}
}
