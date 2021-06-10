//
//  ViewController.swift
//  demo1
//
//  Created by QQ on 2021/6/10.
//  Copyright © 2021 QQ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var timer:Timer!
    fileprivate var timerPanel:FFTimerPanelView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        FFInit()
    }
    
    fileprivate func FFInit() {
        timerPanel = FFTimerPanelView()
        view.addSubview(timerPanel)
        timerPanel.FFStartTimer()
        let tap = UITapGestureRecognizer(target: self, action: #selector(FFAnimation))
        timerPanel.addGestureRecognizer(tap)
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    @objc fileprivate func FFAnimation() {
        timerPanel.FFStartTimer()
    }


}



extension ViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}
