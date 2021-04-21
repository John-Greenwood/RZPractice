//
//  FontScheme.swift
//  Yoga
//
//  Created by User on 07.10.2020.
//  Copyright © 2020 Александр Сенин. All rights reserved.
//

import RelizKit

enum FontType{
    case bold
    case semiBold
    case extraLight
    case light
    case regular
    case medium
            
    func name() -> String {
        switch self {
        case .bold:         return "HelveticaNeue-Bold"
        case .extraLight:   return "NotoSans-ExtraLight"
        case .light:        return "NotoSans-Light"
        case .medium:       return "HelveticaNeue-Medium"
        case .regular:      return "HelveticaNeue"
        case .semiBold:     return "NotoSans-SemiBold"
        }
    }
}

extension UIFont{
    class var largeTitle: UIFont {.getFont(fontType: .bold,     smartSize: 26)}
    class var title1:     UIFont {.getFont(fontType: .bold,     smartSize: 22)}
    class var title2:     UIFont {.getFont(fontType: .bold,     smartSize: 18)}
    class var title3:     UIFont {.getFont(fontType: .bold,     smartSize: 16)}
    class var title4:     UIFont {.getFont(fontType: .medium,   smartSize: 16)}
    class var title5:     UIFont {.getFont(fontType: .bold,     smartSize: 12.5)}
    class var title5r:    UIFont {.getFont(fontType: .regular,  smartSize: 12.5)}
    class var title6:     UIFont {.getFont(fontType: .regular,  smartSize: 13)}
    
    class var h1:         UIFont {.getFont(fontType: .semiBold, smartSize: 22)}
    class var headline:   UIFont {.getFont(fontType: .semiBold, smartSize: 17)}
    class var boby:       UIFont {.getFont(fontType: .regular,  smartSize: 15)}
    class var caption:    UIFont {.getFont(fontType: .regular,  smartSize: 12)}
    
    static func getFont(fontType: FontType, smartSize: CGFloat) -> UIFont{
        if Device.get == .mac{
            return getFont(fontType: fontType, pt: smartSize)
        }else{
            return getFont(fontType: fontType, del: 370.0 / smartSize)
        }
    }
    
    static func getFont(fontType: FontType, del: CGFloat) -> UIFont{
        if Device.get == .iPad{
            return getFont(fontType: fontType, pt: (RZProtoValue.screenTag(.w, .vertical) * 0.8*).getValue() / del)
        }else{
            return getFont(fontType: fontType, pt: RZProtoValue.screenTag(.w, .vertical).getValue() / del)
        }
    }
    
    static func getFont(fontType: FontType, pt: CGFloat) -> UIFont{
        return UIFont(descriptor: UIFontDescriptor(name: fontType.name(), size: 0), size: pt)
    }
    
    static func creatorDel(_ fontType: FontType, _ del: CGFloat) -> UIFont {.getFont(fontType: fontType, del: del)}
    static func creatorPT(_ fontType: FontType, _ pt: CGFloat) -> UIFont {.getFont(fontType: fontType, pt: pt)}
}
