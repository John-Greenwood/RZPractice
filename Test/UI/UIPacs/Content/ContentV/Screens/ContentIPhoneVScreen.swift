//
//  ContentIPhoneVScreen.swift
//  Tutorial
//
//  Created by Александр Сенин on 29.03.2021.
//

import RelizKit
import RZViewBuilder

class ContentIPhoneVScreen: RZUIPacView{
    var router: ContentR!
    
    var contentWidth: RZProtoValue {router.isHorizontal ? 85 % self*.h : 85 % self*.w}
    var closeButtonWidth: RZProtoValue {router.isHorizontal ? 15 % self*.h : 15 % self*.w}
    
    var topSpace: RZProtoValue {router.isHorizontal ? 8 % self*.h : 8 % self*.w}
    var downSpace: RZProtoValue {router.isHorizontal ? 5 % self*.h : 5 % self*.w}
    var rightSpace: RZProtoValue {((router.isHorizontal ? self*.h : self*.w) - contentWidth) / 2* }
    var space: RZProtoValue {router.isHorizontal ? 5 % self*.h : 5 % self*.w}
    
    var scroll = UIScrollView()
    var closeButton = UIButton()
    
    var imageView = UIImageView()
    var label = UILabel()
    var descriptionLabel = UILabel()
    
    func create() {
        createSelf()
        createScroll()
        createCloseButton()
        createImageView()
        createLabel()
        createDescriptionLabel()
    }
    
    
    
    func initActions() {
        
    }
    
    private func createSelf(){
        self+>.color(.a3_8_9D)
    }
    
    private func createScroll(){
        addSubview(scroll)
        scroll.showsVerticalScrollIndicator = false
        scroll.contentInsetAdjustmentBehavior = .never
        scroll+>
            .width(self.contentWidth).height(self|*.h)
            .template(router.$isHorizontal.switcher([
                false: .custom{[weak self] scroll in
                    guard let self = self else {return}
                    scroll+>.x(self|*.scX, .center)
                },
                true: .custom{[weak self] scroll in
                    guard let self = self else {return}
                    scroll+>.x(self.imageView|*.mX >< self|*.w, .center)
                }
            ]))
            .contentHeight(descriptionLabel|*.mY + downSpace)
    }
    
    private func createCloseButton(){
        addSubview(closeButton)
        closeButton+>
            .color(.a1_6P_8M)
            .width(closeButtonWidth).height(.selfTag(.w)).x(self|*.w, .right).y(topSpace - (25 % closeButton|*.h))
            .mask(UIImageView(image: router.closeButtonImage)+>.width(50 % closeButton|*.w).height(50 % closeButton|*.w).view)
            .addAction(router.closeButtonAction)
    }
    
    private func createImageView(){
        imageView+>
            .image(router.image)
            .width(contentWidth).height(.selfTag(.w))
            .template(router.$isHorizontal.switcher([
                false: .custom{[weak self] imageView in
                    guard let self = self else {return}
                    self.scroll.addSubview(imageView)
                    imageView+>.x(0*).y(self.topSpace)
                },
                true: .custom{[weak self] imageView in
                    guard let self = self else {return}
                    self.addSubview(imageView)
                    imageView+>.x(25 % self*.w, .center).y(self*.scY, .center)
                }
            ]))
    }
    
    private func createLabel(){
        scroll.addSubview(label)
        label+>
            .text(router.labelText).font(.largeTitle).color(.a1_6P_8M, .content)
            .sizeToFit()
            .template(router.$isHorizontal.switcher([
                false: .custom{[weak self] label in
                    guard let self = self else {return}
                    label+>.y(self.imageView|*.mY + self.space)
                },
                true: .custom{[weak self] label in
                    guard let self = self else {return}
                    label+>.y(self.space)
                }
            ]))
    }
    
    private func createDescriptionLabel(){
        scroll.addSubview(descriptionLabel)
        descriptionLabel+>
            .text(router.descriptionText).font(.title2).color(.a1_6P_8M, .content).lines(0)
            .sizeToFit().width(contentWidth).y(self.label|*.mY + self.space)
    }
}
