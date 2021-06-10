//
//  FFNumberCurlView.swift
//  demo1
//
//  Created by QQ on 2021/6/10.
//  Copyright © 2021 QQ. All rights reserved.
//

import UIKit

class FFNumberCurlView: UIView {
    
    private var currentTimeLabel:UILabel!
    private var animationLabel:UILabel!
    private var nextTimeLabel:UILabel!
    private var link:CADisplayLink!
    private var anitamionValue = 0.0
    private let initAngle:Float = 0.01
    
    var font:UIFont = UIFont.systemFont(ofSize: 18) {
        willSet {
            currentTimeLabel.font = newValue
            animationLabel.font = newValue
            nextTimeLabel.font = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        FFInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        currentTimeLabel.frame = bounds
        nextTimeLabel.frame = bounds
        animationLabel.frame = bounds
    }
    
    func FFSetUpCurrentTime(current:Int, next:Int) {
        currentTimeLabel.text = "\(current)"
        animationLabel.text = "\(current)"
        nextTimeLabel.text = "\(next)"
        anitamionValue = 0.0
        nextTimeLabel.isHidden = true
        FFAnimationStart()
    }
    
    /** view set**/
    private func FFInit() {
        FFSetUpLabel()
        FFAddSubView()
        link = CADisplayLink(target: self, selector: #selector(FFNumberCurlView.FFAnimationUpdate))
        link.preferredFramesPerSecond = 30
    }
    
    private func FFAddSubView() {
        addSubview(currentTimeLabel)
        addSubview(nextTimeLabel)
        
        FFSetUpTransform(view: nextTimeLabel)
        nextTimeLabel.isHidden = true
        
        addSubview(animationLabel)
        FFSetUpTransform(view: animationLabel)
    }
    
    private func FFSetUpLabel() {
        currentTimeLabel = FFAcquireLabel()
        animationLabel = FFAcquireLabel()
        nextTimeLabel = FFAcquireLabel()
    }
    
    private func FFAcquireLabel() -> UILabel {
        let label:UILabel = UILabel()
        let initTimeFontSize = 18
        label.font = UIFont.systemFont(ofSize: CGFloat(initTimeFontSize) * ScaleOf375, weight: .medium)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        
        return label
    }
    
    private func FFSetUpTransform(view:UILabel) {
        var tran = CATransform3DIdentity
        tran.m34 = CGFloat(Float.leastNormalMagnitude)
        view.layer.transform = CATransform3DRotate(tran, CGFloat(Float.pi * 0.01), -1, 0, 0)
    }
    
    /** animation **/
    private func FFAnimationStart() {
        link.add(to: RunLoop.current, forMode: .common)
    }
    
    private func FFAnimationStop() {
        link.remove(from: RunLoop.current, forMode: .common)
    }
    
    @objc private func FFAnimationUpdate() {
        anitamionValue += 2.0 / 60.0
        var trans = CATransform3DIdentity
        trans.m34 = CGFloat(Float.leastNormalMagnitude)
        var t = CATransform3DRotate(trans, CGFloat(anitamionValue * Double.pi), -1, 0, 0)
        if anitamionValue >= 0.5 {
            t = CATransform3DRotate(t, CGFloat(CGFloat.pi), 0, 1, 0)
            t = CATransform3DRotate(t, CGFloat(CGFloat.pi), 0, 0, 1)
            animationLabel.text = nextTimeLabel.text ?? ""
        }
        
        if anitamionValue >= Double(initAngle) {
            nextTimeLabel.isHidden = false
        }
        
        animationLabel.layer.transform = t
        if anitamionValue >= 0.95 {
            FFAnimationStop()
            currentTimeLabel.text = nextTimeLabel.text ?? ""
        }
    }
    
}
