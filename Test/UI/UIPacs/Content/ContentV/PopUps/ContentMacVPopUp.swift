//
//  ContentMacVPopUp.swift
//  Tutorial
//
//  Created by Александр Сенин on 29.03.2021.
//

import RelizKit

struct ContentMacVPopUp: RZSUIPacView{
    @ObservedObject var router: ContentR
    
    var body: some View{
        Button {
            router.closeButtonAction()
        } label: {
            HStack{
                VStack{
                    Spacer()
                    Text(router.labelText).font(Font(UIFont.largeTitle)).foregroundColor(Color(.c6P)).padding()
                }
                Spacer()
            }.background(Image(router.imageName).resizable())
        }.buttonStyle(PlainButtonStyle())
    }
}
