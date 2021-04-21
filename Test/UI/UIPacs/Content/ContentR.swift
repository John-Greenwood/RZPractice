//
//  ContentR.swift
//  Tutorial
//
//  Created by Александр Сенин on 29.03.2021.
//

import RelizKit

class ContentR: RZUIPacRouter{
    @RZObservable var isHorizontal = false
    
    var imageName = "image"
    var image: UIImage? { UIImage(named: imageName) }
    var closeButtonImage = UIImage(named: "close")
    
    var labelText: String = "Скручивание"
    var descriptionText: String = "Лягте на спину. Вытяните руки в стороны на одной линии с плечами так, чтобы тело приняло форму креста.\n\nПоднимите и согните правую ногу в колене. Не отрывая плеч, рук и левой ноги от пола повернитесь на левый бок. Правым коленом попытайтесь достать пола с левой стороны от корпуса. Если колено не достает, то следует добавить ей нагрузку левой рукой, то есть положить левую кисть на правое колено и слегка надавить. Голову следует повернуть направо и посмотреть на кисть правой руки. Расслабьтесь полностью.\n\nПребывайте в этой позиции 50 секунд. Затем вернитесь в обратном порядке в исходное положение и повторите упражнение в другую сторону"
    
    //MARK: - API
    //MARK: - ActionsC
    var closeButtonAction = {}
}
