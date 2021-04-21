//
//  ContentIPadVScreen.swift
//  Tutorial
//
//  Created by Александр Сенин on 29.03.2021.
//

import RelizKit

class ContentIPadVScreen: ContentIPhoneVScreen{
    override var contentWidth: RZProtoValue {router.isHorizontal ? 68 % self*.h : 68 % self*.w}
}
