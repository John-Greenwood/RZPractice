//
//  MenuIPadV.swift
//  Tutorial
//
//  Created by Александр Сенин on 29.03.2021.
//

import RelizKit

class MenuIPadV: MenuIPhonV{
    override var buttonsSpace: RZProtoValue {router.isHorizontal ? 2 % (self*.h * 0.8*) : 2 % (self*.w * 0.8*)}
}
