//
//  FFTimerPanelView.swift
//  demo1
//
//  Created by QQ on 2021/6/10.
//  Copyright © 2021 QQ. All rights reserved.
//

import UIKit

class FFTimerPanelView: FFView {
    
    var font:UIFont = UIFont.systemFont(ofSize: 18) {
        willSet {
            hourView.font = newValue
            minuteView.font = newValue
            secondView.font = newValue
            if newValue.fontName == SystemFontName {
                dateLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
            }else {
                dateLabel.font = UIFont(name: newValue.fontName, size: 18)
            }
        }
    }
    
    private var width:CGFloat = 180.0 * ScaleOf375
    private var height:CGFloat = 120.0 * ScaleOf375
    private var dis:CGFloat!
    
    private var hourView:FFPanelPartView!
    private var minuteView:FFPanelPartView!
    private var secondView:FFPanelPartView!
    
    private var timer:Timer!
    
    
    
    private lazy var dateLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.white
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            dateLabel.frame = CGRect(x: StatusBarHeight + 1, y: 20, width: ScreenWidth - 40, height: 25)
            
            let dis = (UIScreen.main.bounds.size.width - width * 3) / 4.0
            let top = (UIScreen.main.bounds.size.height - height) / 2.0
            hourView.frame = CGRect(x: dis, y: top, width: width, height: height)
            minuteView.frame = CGRect(x: dis * 2 + width, y: top, width: width, height: height)
            secondView.frame = CGRect(x: dis * 3 + width * 2, y: top, width: width, height: height)
        }else {
            dateLabel.frame = CGRect(x: 20, y: StatusBarHeight + 10, width: ScreenWidth - 40, height: 25)
            
            let left = (ScreenWidth - width) / 2.0
            let dis = (ScreenHeight - height * 3) / 4.0 * ScaleOf375
            hourView.frame = CGRect(x: left, y: dis, width: width, height: height)
            minuteView.frame = CGRect(x: left, y: dis * 2 + height, width: width, height: height)
            secondView.frame = CGRect(x: left, y: dis * 3 + height * 2, width: width, height: height)
        }
    }
    
    override func FFInit() {
        backgroundColor = UIColor.black
        
        
        timer = Timer.FFInitTimer(timeInterval: 1.0, repeats: true, block: { [weak self](_) in
            self?.FFSetUpTime()
        })
        
        addSubview(dateLabel)
        FFRefreshBasicSet()
        
        dis = (ScreenHeight - height * 3) / 4.0 * ScaleOf375
        hourView = FFContainerView(dis)
        minuteView = FFContainerView(dis * 2 + height)
        secondView = FFContainerView(dis * 3 + height * 2)
        
        addSubview(hourView)
        addSubview(minuteView)
        addSubview(secondView)
        
        FFRefreshFont()
        FFAddFontChangeObserver()
    }
    
    /// 启动计时器， 将timer 加入 runloop中
    func FFStartTimer() {
        RunLoop.current.add(timer, forMode: .common)
    }
    
    /// 销毁计时器
    func FFInvalidateTimer() {
        timer.invalidate()
    }
    
    private func FFSetUpYearMonthDay() -> String{
        let date = Date()
        let calendar:Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let components:DateComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        let weakday = components.weekday ?? 0
        var weak = ""
        switch weakday {
        case 1:
            weak = "周日"
        case 2:
            weak = "周一"
        case 3:
            weak = "周二"
        case 4:
            weak = "周三"
        case 5:
            weak = "周四"
        case 6:
            weak = "周五"
        case 7:
            weak = "周六"
        default:
            weak = "未知"
        }
        return "\(components.year ?? 1977)年\(components.month ?? 01)月\(components.day ?? 01)日 \(weak)"
    }
    
    /// 设置时分秒
    private func FFSetUpTime() {
        let date = Date()
        let nextDate = Date(timeIntervalSinceNow: 1)
        let calendar:Calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let components:DateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
        let nextComponents:DateComponents = calendar.dateComponents([.hour, .minute, .second], from: nextDate)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let second = components.second ?? 0
        let nextHour = nextComponents.hour ?? 0
        let nextMinute = nextComponents.minute ?? 0
        let nextSecond = nextComponents.second ?? 0
        hourView.FFSetUpTime(hour, nextHour)
        minuteView.FFSetUpTime(minute, nextMinute)
        secondView.FFSetUpTime(second, nextSecond)
    }
    
    
    private func FFContainerView(_ dis:CGFloat) -> FFPanelPartView{
        let left = (ScreenWidth - width) / 2.0
        let vi = FFPanelPartView(frame: CGRect(x: left, y: dis, width: width, height: height))
        return vi
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


extension FFTimerPanelView {
    
    /// 更新字体样式
    fileprivate func FFAddFontChangeObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(FFRefreshBasicSet), name: NSNotification.Name(UpdateBasicState), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FFRefreshFont), name: NSNotification.Name(UpdateFont), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(FFRefreshFont), name: NSNotification.Name(UpdateFontSize), object: nil)
        //    NotificationCenter.default.addObserver(self, selector: #selector(FFChange), name: UIDevice.orientationDidChangeNotification, object: nil)
        
    }
    
    /// 监听方向的改变 没有使用
    private func FFAddOrientationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(FFChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc private func FFRefreshBasicSet() {
        let arr:[Bool] = FFStoreHelper.share.FFGetBasicState()
        if arr[0] == false && arr[1] == false {
            dateLabel.text = " "
        }else if arr[0] == false {
            dateLabel.text = FFSetUpYearMonthDay().components(separatedBy: " ").last ?? ""
        }else if arr[1] == false {
            dateLabel.text = FFSetUpYearMonthDay().components(separatedBy: " ").first ?? ""
        }else if arr[0] && arr[1] {
            dateLabel.text = FFSetUpYearMonthDay()
        }
    }
    /// 更新字体
    @objc private func FFRefreshFont() {
        let str:String = FFStoreHelper.share.FFGetSelectFont()
        initTimeFontSize = FFStoreHelper.share.FFGetSelectFontSize()
        if str == SystemFontName {
            font = UIFont.systemFont(ofSize: CGFloat(initTimeFontSize) * ScaleOf375, weight: .medium)
        }else {
            font = UIFont(name: str, size: CGFloat(initTimeFontSize) * ScaleOf375)!
        }
    }
    
    /// 监听方向的改变 没有使用
    @objc private func FFChange() {
        let orientation:UIDeviceOrientation = UIDevice.current.orientation;
        switch orientation {
        case .unknown:
            print("未知")
        case .portrait:
            print("屏幕直立")
        case .portraitUpsideDown:
            print("屏幕倒立")
        case .landscapeLeft:
            print("屏幕左在上方")
        case .landscapeRight:
            print("屏幕右在上方")
        case .faceUp:
            print("屏幕朝上")
        case .faceDown:
            print("屏幕朝下")
        default:
            print("...")
        }
    }
    
    
}

