//
//  ReminderC.swift
//  Test
//
//  Created by John Greenwood on 20.04.2021.
//

import RelizKit

class ReminderC: RZUIPacController {
    
    var iPhoneViewType: RZUIPacAnyViewProtocol.Type? {ReminderIPhoneVScreen.self}
    var iPadViewType: RZUIPacAnyViewProtocol.Type? {ReminderIPhoneVScreen.self}
    
    var router = ReminderR()
    
    func initActions() {
        createSkipAction()
        createButtonModels()
        createButtonActions()
        createPlanButtonAction()
    }
    
    // MARK: Button models
    private func createButtonModels() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "ru_RU")
        var i = 1
        router.buttonModels = calendar.veryShortWeekdaySymbols.map {
            let model = DayButtonModel($0)
            model.day = i
            i+=1
            return model
        }
        router.buttonModels.insert(router.buttonModels.remove(at: 0), at: 6)
    }
    
    // MARK: Button actions create
    private func createSkipAction() {
        router.skipButtonAction = { [weak self] in
            self?.skip()
        }
    }
    
    private func createButtonActions() {
        for (i, _) in router.buttonModels.enumerated() {
            router.buttonModels[i].action = { [weak self] in
                self?.router.buttonModels[i].isSelected.toggle()
            }
        }
    }
    
    private func createPlanButtonAction() {
        router.planButtonAction = { [weak self] in
            guard let self = self else { return }
            self.createNotifications(self.router.selectedTime)
        }
    }
    
    // MARL: Actions
    private func skip() {
        RZTransition(.Instead, self).back().animation(.shiftRight).transit()
    }
    
    private func createNotifications(_ time: Date) {
        let manager = NotificationsManager.shared
        manager.clearPendding()
        
        for model in router.buttonModels {
            guard model.isSelected else { continue }
            manager.createNotifications(for: model.day, at: time)
        }
    }
}
