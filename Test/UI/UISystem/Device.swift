//
//  Devise.swift
//  Tutorial
//
//  Created by Александр Сенин on 29.03.2021.
//

import Foundation
import UIKit

enum Device {
    case iPhone
    case iPad
    case mac
    
    static var get: Self {
        #if targetEnvironment(macCatalyst)
            return .mac
        #else
            if UIDevice.current.userInterfaceIdiom == .pad{
                return .iPad
            }else {
                return .iPhone
            }
        #endif
    }
}
