//
//  FFPanelPartView.swift
//  demo1
//
//  Created by QQ on 2021/6/10.
//  Copyright © 2021 QQ. All rights reserved.
//

import UIKit

class FFPanelPartView: FFView {
    
    var font:UIFont = UIFont.systemFont(ofSize: 18) {
        willSet {
            leftLabel.font = newValue
            rightLabel.font = newValue
        }
    }
    
    private lazy var separatorLine:UIView = {
        let vi = UIView()
        vi.backgroundColor = UIColor.white
        return vi
    }()
    
    
    private var leftLabel:FFNumberCurlView!
    private var rightLabel:FFNumberCurlView!
    private var leftRecordTime:Int?
    private var rightRecordTime:Int?
    
    override func FFInit() {
        layer.cornerRadius = 10 * ScaleOf375
        layer.masksToBounds = true
        leftLabel = FFNumberCurlView()
        addSubview(leftLabel)
        
        rightLabel = FFNumberCurlView()
        addSubview(rightLabel)
        
        addSubview(separatorLine)
        
    }
    
    
    /// 数字变化
    /// - Parameters:
    ///   - current: 当前时间
    ///   - next: 下一秒时间
    func FFSetUpTime(_ current:Int, _ next:Int) {
        let currentLeft = current / 10
        let currentRight = current % 10
        let nextLeft = next / 10
        let nextRight = next % 10
        FFSetUpLeftTime(currentLeft, nextLeft)
        FFSetUpRightTime(currentRight, nextRight)
    }
    
    /// 左侧数字变化
    /// - Parameters:
    ///   - current: 当前
    ///   - next: 下一个
    private func FFSetUpLeftTime(_ current:Int, _ next:Int) {
        if let record = leftRecordTime, record == next {
        }else {
            leftRecordTime = next
            leftLabel.FFSetUpCurrentTime(current: current, next: next)
        }
    }
    
    
    /// 右侧数字变化
    /// - Parameters:
    ///   - current: 当前
    ///   - next: 下一个
    private func FFSetUpRightTime(_ current:Int, _ next:Int) {
        if let record = rightRecordTime, record == current {
        }else {
            rightRecordTime = current
            rightLabel.FFSetUpCurrentTime(current: current, next: next)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        leftLabel.frame = CGRect(x: 0, y: 0, width: CGFloat(floorf(Float(bounds.size.width / 2.0))), height: bounds.size.height)
        let temp = leftLabel.bounds.size.width
        rightLabel.frame = CGRect(x: temp, y: 0, width: bounds.size.width - temp, height: bounds.size.height)
        separatorLine.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: 5 * ScaleOf375)
        separatorLine.center = CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height / 2.0)
        
    }
    
}

