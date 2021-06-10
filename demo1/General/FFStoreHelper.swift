//
//  FFStoreHelper.swift
//  demo1
//
//  Created by QQ on 2021/6/10.
//  Copyright © 2021 QQ. All rights reserved.
//

import UIKit

class FFStoreHelper: NSObject {
    
    static let share:FFStoreHelper = FFStoreHelper()
    
    private override init(){
        super.init()
    }
    
    func FFSetUpSelectFont(font:String) {
        UserDefaults.standard.set(font, forKey: "UIFont")
        UserDefaults.standard.synchronize()
    }
    
    func FFGetSelectFont() -> String {
        let obj:Any? = UserDefaults.standard.object(forKey: "UIFont")
        guard let font = obj else {
            return SystemFontName
        }
        return font as! String
    }
    
    func FFSetUpSelectFontSize(size:Int) {
        UserDefaults.standard.set(size, forKey: "FontSize")
        UserDefaults.standard.synchronize()
    }
    
    func FFGetSelectFontSize() -> Int {
        let size = UserDefaults.standard.integer(forKey: "FontSize")
        if size == 0 {
            return initTimeFontSize
        }else {
            return size
        }
    }
    
    
    func FFSetUpSelectBasicState(arr:[Bool]) {
        UserDefaults.standard.set(arr, forKey: "Basic")
        UserDefaults.standard.synchronize()
    }
    
    func FFGetBasicState() -> [Bool] {
        let obj:Any? = UserDefaults.standard.object(forKey: "Basic")
        guard let font = obj else {
            return [true, true, true]
        }
        return font as! [Bool]
        
    }
}
