//
//  ReminderIPhoneVScreen.swift
//  Test
//
//  Created by John Greenwood on 20.04.2021.
//

import RelizKit
import RZViewBuilder

class ReminderIPhoneVScreen: RZUIPacView {
    
    var router: ReminderR!
    
    var vSpace           : RZProtoValue {10 % self*.w}
    var hSpace           : RZProtoValue {10 % self*.w}
    var dayButtonSize    : RZProtoValue {10 % self*.w}
    var planButtonHeight : RZProtoValue {15 % self*.w}
    var maxWidth         : RZProtoValue {self*.w - hSpace * 2*}
    
    var skipButton      = UIButton()
    var titleLabel      = UILabel()
    var buttonsStack    = UIStackView()
    var datePicker      = UIDatePicker()
    var quoteLabel      = UILabel()
    var quoteAutorLabel = UILabel()
    var planButton      = UIButton(type: .system)
    
    var buttons: [UIButton] = []
    
    func create() {
        createSelf()
        createSkipButton()
        createTitleLabel()
        createButtonsStack()
        createDayButtons()
        createDatePicker()
        createPlanButton()
        createQuoteAutorLabel()
        createQuoteLabel()
    }
    
    // MARK: Views creation
    
    private func createSelf() {
        self+>.color(.a3_8_9D)
    }
    
    private func createSkipButton() {
        addSubview(skipButton)
        skipButton+>
            .x(self|*.mX - hSpace, .right).y(safeAreaInsets.top*)
            .text(router.skipButtonText)
            .color(.c13, .content)
            .sizeToFit()
            .addAction(router.skipButtonAction)
        
        let atr: [NSAttributedString.Key: Any] = [.underlineStyle: NSUnderlineStyle.single.rawValue, .font: UIFont.boby as Any]
        let str = NSMutableAttributedString(string: router.skipButtonText,
                                            attributes: atr)
        skipButton.setAttributedTitle(str, for: .normal)
    }
    
    private func createTitleLabel() {
        addSubview(titleLabel)
        titleLabel+>
            .x(self|*.cX, .center).y(skipButton|*.mY + vSpace)
            .width(maxWidth)
            .lines(0)
            .aligment(.center)
            .font(.largeTitle)
            .text(router.titleText)
            .color(.c9ED | .c8, .content)
            .sizeToFit()
    }
    
    private func createButtonsStack() {
        addSubview(buttonsStack)
        buttonsStack+>
            .x(hSpace).y(titleLabel|*.mY + vSpace)
            .width(self|*.w - hSpace * 2*).height(dayButtonSize)
        buttonsStack.spacing = 0
        buttonsStack.distribution = .equalSpacing
        buttonsStack.alignment = .center
    }
    
    private func createDayButtons() {
        for model in router.buttonModels {
            let button = createButton(model)
            buttons.append(button)
            buttonsStack.addArrangedSubview(button)
        }
        buttonsStack.sizeToFit()
    }
    
    private func createButton(_ model: DayButtonModel) -> UIButton {
        let button = UIButton()
        button+>
            .width(dayButtonSize).height(dayButtonSize)
            .cornerRadius(dayButtonSize / 2*)
            .text(model.$text)
            .template(model.$isSelected.switcher([
                true: .custom { [weak self] button in
                    guard let self = self else { return }
                    button+>
                        .color(self.router.primaryColor, .background)
                        .color(.c8, .content)
                },
                false: .custom({ [weak self] button in
                    guard let self = self else { return }
                    button+>
                        .color(self.router.secondaryColor, .background)
                        .color(self.router.primaryColor, .content)
                })
            ]))
            .addAction(model.action)
        NSLayoutConstraint.activate([
                                        button.widthAnchor.constraint(equalToConstant: dayButtonSize.getValue()),
            button.heightAnchor.constraint(equalToConstant: dayButtonSize.getValue())])
        
        return button
    }
    
    private func createDatePicker() {
        addSubview(datePicker)
        datePicker+>
            .width(maxWidth).height(40 % self|*.h)
            .x(self|*.cX, .center).y(buttonsStack|*.mY + vSpace)
            .color(router.primaryColor, .content)
        if #available(iOS 13.4, *) { datePicker.preferredDatePickerStyle = .wheels }
        datePicker.datePickerMode = .time
        datePicker.setValue(router.primaryColor, forKey: "textColor")
        datePicker.addTarget(self, action: #selector(timeDidSelected), for: .valueChanged)
    }
    
    private func createPlanButton() {
        addSubview(planButton)
        planButton+>
            .width(maxWidth).height(planButtonHeight)
            .x(self|*.cX, .center).y(self|*.mY - vSpace, .down)
            .color(router.primaryColor, .background)
            .color(.white, .content)
            .text(router.planbuttonText)
            .cornerRadius(planButtonHeight / 2*)
            .addAction(router.planButtonAction)
    }
    
    private func createQuoteAutorLabel() {
        addSubview(quoteAutorLabel)
        quoteAutorLabel+>
            .x(self|*.cX, .center).y(planButton|*.y - vSpace * 2*, .down)
            .text(router.quoteAutorText)
            .font(.caption)
            .color(.c9ED | .c8, .content)
            .sizeToFit()
    }
    
    private func createQuoteLabel() {
        addSubview(quoteLabel)
        quoteLabel+>
            .x(self|*.cX, .center).y(quoteAutorLabel|*.y - (1 % self|*.w), .down)
            .text(router.quoteText)
            .font(.title5)
            .color(.c9ED | .c8, .content)
            .sizeToFit()
    }
    
    @objc func timeDidSelected() {
        router.selectedTime = datePicker.date
    }
}
