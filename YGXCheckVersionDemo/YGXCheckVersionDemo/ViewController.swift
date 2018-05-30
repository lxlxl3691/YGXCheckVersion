//
//  ViewController.swift
//  YGXCheckVersionDemo
//
//  Created by michael 伊 on 2018/5/30.
//  Copyright © 2018年 michael 伊. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var checkVersion: YGXCheckVersion = {
        return YGXCheckVersion()
    }()
    
    lazy var button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .red
        btn.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        btn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(button)
    }

    @objc func buttonClick() {
        /// 使用默认UI,通过bundleID检查更新(不强制更新,每次提示)
        checkVersion.checkWithStore(isForce: false, isDaily: false)
        
        /// 自定义UI,通过bundleID检查更新,返回更新内容以及iTunes连接
        //        checkUpdate.updataWithBlock(isDaily: false) { (note, itunesUrl) in
        //            print(note,itunesUrl)
        //            /* 自定义弹框 */
        //        }
    }
}

