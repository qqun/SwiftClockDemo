//
//  FFTimer.swift
//  demo1
//
//  Created by QQ on 2021/6/10.
//  Copyright © 2021 QQ. All rights reserved.
//

import UIKit

class Block<T> {
    let f : T
    init(_ f: T) {
        self.f = f;
    }
}

extension Timer {
    class func FFScheduledTime(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
        if #available(iOS 10.0, *) {
            return Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: block)
        } else {
            return Timer.scheduledTimer(timeInterval: interval, target: self, selector: Selector(("FFTimerAction")), userInfo: Block(block), repeats: true)
        }
    }
    
    @objc class func FFTimerAction(_ sender : Timer) {
        if let block = sender.userInfo as? Block<(Timer) -> Void> {
            block.f(sender)
        }
    }
    
    class func FFInitTimer(timeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
        if #available(iOS 10.0, *) {
            return Timer(timeInterval: interval, repeats: repeats, block: block)
        }
        return Timer(timeInterval: interval, target: self, selector: #selector(FFTimerAction(_:)), userInfo: Block(block), repeats: repeats)
    }
}
