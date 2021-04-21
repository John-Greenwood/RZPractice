//
//  UITemplate.swift
//  Yoga
//
//  Created by Александр Сенин on 10.03.2021.
//  Copyright © 2021 Александр Сенин. All rights reserved.
//

import RelizKit

enum RZVBTemplatePosition{
    case vertical
    case horizontal
    case all
    
    case right
    case left
    case up
    case down
}

extension RZVBTemplate{
    static func custom(_ template: @escaping (View)->()) -> Self {RZVBTemplate(template)}
    static func custom(_ template: @escaping (View, RZVBTemplate.Complition)->()) -> Self {RZVBTemplate(template)}
    
    static func center(_ position: RZVBTemplatePosition = .all) -> Self {
        .custom {
            switch position {
                case .vertical:   $0+>.y(.screenTag(.scY), .center)
                case .horizontal: $0+>.x(.screenTag(.scX), .center)
                default:          $0+>.x(.screenTag(.scX), .center).y(.screenTag(.scY), .center)
            }
        }
    }
    
    static func space(_ position: RZVBTemplatePosition = .all, _ value: RZProtoValue? = nil) -> Self {
        .custom {
            var value = value
            switch position {
            case .left:
                if value == nil {
                    switch Device.get{
                        case .iPad:
                            value = 5 % (.screenTag(.w) * 0.8*)
                        case .iPhone:
                            value = 5 % .screenTag(.w)
                        case .mac:
                            value = 50*
                    }
                }
                $0+>.x(value!)
            case .right:
                if value == nil {
                    switch Device.get{
                        case .iPad:
                            value = 5 % (.screenTag(.w) * 0.8*)
                        case .iPhone:
                            value = 5 % .screenTag(.w)
                        case .mac:
                            value = 50*
                    }
                }
                $0+>.x(.screenTag(.w, .auto) - value!, .right)
            case .up:
                if value == nil {
                    switch Device.get{
                        case .iPad:
                            value = 12 % (.screenTag(.w) * 0.8*)
                        case .iPhone:
                            value = 12 % .screenTag(.w)
                        case .mac:
                            value = 70*
                    }
                }
                $0+>.y(value!)
            case .down:
                if value == nil {
                    switch Device.get{
                        case .iPad:
                            value = 5 % .screenTag(.h)
                        case .iPhone:
                            value = 5 % .screenTag(.h)
                        case .mac:
                            value = 50*
                    }
                }
                $0+>.y(.screenTag(.h, .auto) - value!, .down)
            default: break
            }
        }
    }
}

//MARK: - Text buttons
enum ButtonId{
    case b1
    case custom(RZVBTemplate<UIButton>)
}
enum ButtonsTemplateElement{
    case size(ButtonId? = nil)
    case position(ButtonId? = nil)
    case color(ButtonId? = nil)
    case font(ButtonId? = nil)
}

//MARK: - Text buttons presets
extension RZVBTemplate where View: UIButton{
    static var b1: Self {
        .custom{view in
            view+>.template(.textButton(.b1))
        }
    }
}

extension RZVBTemplate {
    //MARK: - buttons sizes
    static var b1Size: Self {
        .custom{
            switch Device.get{
                case .iPad:
                    $0+>.width(86 % (.screenTag(.w) * 0.8*))
                case .iPhone:
                    $0+>.width(86 % .screenTag(.w))
                case .mac:
                    $0+>.width(300)
            }
            $0+>.height(17.5 % .selfTag(.w)).cornerRadius($0|*.h / 2*)
        }
    }
    //MARK: - buttons positions
    static var b1Position: Self {
        .custom{
            $0+>.template(.center(.horizontal), .space(.down))
        }
    }
    //MARK: - buttons colors
    static var b1Color: Self {
        .custom{
            $0+>.color(.c1P).color(.c8, .content)
        }
    }
}
extension RZVBTemplate where View: UIButton{
    //MARK: - buttons fonts
    static var b1Font: Self {
        .custom{
            $0+>.font(.title3)
        }
    }
}

//MARK: - Text button universal logic
extension RZVBTemplate where View: UIButton{
    static func textButton(_ id: ButtonId, _ elements: ButtonsTemplateElement...) -> Self {
        .custom{
            var elements = elements
            if elements.count == 0{ elements = [.color(), .size(), .position(), .font()] }
            for element in elements { useButtonTemplateAt($0, id, element) }
        }
    }
    
    private static func useButtonTemplateAt(_ view: UIButton, _ defaultID: ButtonId, _ element: ButtonsTemplateElement){
        switch element {
        case .color(let idL):
            let id = idL ?? defaultID
            switch id {
                case .b1: view+>.template(.b1Color)
                case .custom(let template): view+>.template(template)
            }
        case .position(let idL):
            let id = idL ?? defaultID
            switch id {
                case .b1: view+>.template(.b1Position)
                case .custom(let template): view+>.template(template)
            }
        case .size(let idL):
            let id = idL ?? defaultID
            switch id {
                case .b1: view+>.template(.b1Size)
                case .custom(let template): view+>.template(template)
            }
        case .font(let idL):
            let id = idL ?? defaultID
            switch id {
                case .b1: view+>.template(.b1Font)
                case .custom(let template): view+>.template(template)
            }
        }
    }
}


//MARK: - Image buttons
extension RZVBTemplate where View: UIButton{
    static var xButton: Self {
        .custom{
            $0+>
                .color(.c6P)
                .width(10 % .screenTag(.w)).height(.selfTag(.w))
                .mask(UIImageView(image: UIImage(named: "X"))+>.width(50 % $0*.w).height(.selfTag(.w)).view)
        }
    }
    
    static var backButton: Self {
        .custom{
            $0+>
                .color(.c6P)
                .width(10 % .screenTag(.w)).height(.selfTag(.w))
                .mask(UIImageView(image: UIImage(named: "left"))+>.width(50 % $0*.w).height(.selfTag(.w)).view)
        }
    }
}
