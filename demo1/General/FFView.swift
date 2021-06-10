//
//  FFView.swift
//  demo1
//
//  Created by QQ on 2021/6/10.
//  Copyright © 2021 QQ. All rights reserved.
//

import UIKit

let ScreenWidth = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)

let ScreenHeight = max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)

let isIPhoneXRSeries = (UIScreen.main.bounds.size.height == 812.0 || UIScreen.main.bounds.size.height == 896.0)

let StatusBarHeight:CGFloat = isIPhoneXRSeries ? 44.0 : 20.0

//#if #available(iOS 13.0, *)
//let StatusBarHeight = UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 20
//#else
//    let StatusBarHeight = UIApplication.shared.statusBarFrame.size.height
//#endif

let ScreenScale = UIScreen.main.scale

let ScaleOf375 = (ScreenWidth < ScreenHeight ? ScreenWidth : ScreenHeight) / 375.0

var initTimeFontSize = 90

let SystemFontName = ".SFUI-Medium"

let UpdateFont:String = "UpdateFont"

let UpdateFontSize:String = "UpdateFontSize"

let UpdateBasicState:String = "UpdateBasicState"



func FFColorRGB(_ r:CGFloat, _ g:CGFloat, _ b:CGFloat, _ a:CGFloat = 1.0) -> UIColor {
    return UIColor(displayP3Red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}

class FFView : UIView {
    override init(frame: CGRect) {
        super.init(frame:frame)
        FFInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func FFInit() {
        
    }
    
}
