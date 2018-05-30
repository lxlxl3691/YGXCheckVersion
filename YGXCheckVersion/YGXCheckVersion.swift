//
//  YGXCheckVersion.swift
//  YGXCheckVersionDemo
//
//  Created by michael 伊 on 2018/5/30.
//  Copyright © 2018年 michael 伊. All rights reserved.
//

import UIKit
import Foundation

/// 闭包参数 $0:提示内容, $1:iTunes链接
public typealias YGXCheckVersionBlock = (_ notes: String, _ openUrl: String) -> Void

public class YGXCheckVersion: NSObject {
    
    /// 利用BundleId访问App Store,检测更新,自定义提示框
    ///
    /// - Parameter _isDaily: 是否每日首次提示
    public func checkWithStoreBlock(isDaily: Bool, block: @escaping YGXCheckVersionBlock) {
        if isDaily {
            checkVersionByDaily {
                ApiRequest(block: block)
            }
        }
        else {
            ApiRequest(block: block)
        }
    }
    
    /// 利用BundleId访问App Store,检测更新,系统提示框
    ///
    /// - Parameters:
    ///   - isForce: 是否强制更新
    ///   - isDaily: 是否每日首次提示
    public func checkWithStore(isForce: Bool, isDaily: Bool) {
        self.checkWithStoreBlock(isDaily: isDaily) { (note, url) in
            showAlert(message: note, openUrl: url, isForce: isForce)
        }
    }
}

fileprivate func ApiRequest(block: @escaping YGXCheckVersionBlock) {
    YGXAPITool.share.postWithPath(path: UrlPath.store.rawValue, paras: appStoreData.params, success: { (resultDict) in
        let count = resultDict["resultCount"] as! Int
        var result: [String : Any] = [:]
        var note: String = ""
        var storeVer: String = ""
        var url: String = ""
        if count == 0  {
            print("检测出未上架的APP或者查询不到")
            return
        }
        else {
            if let resultArr = resultDict["results"] as? Array<[String : Any]> {
                result = resultArr[0]
                note = result["releaseNotes"] as! String
                storeVer = result["version"] as! String
                url = result["trackViewUrl"] as! String
            }
            /// 比较当前版本号与App Store上的版本号
            /// currentVer="1.1.0", storeVer"1.2.0" 返回true
            if (systemData.curVer.versionToInt().lexicographicallyPrecedes(storeVer.versionToInt())) {
                block(note, url)
            }
        }
    }) { (error) in
        
    }
}

/// 每日首次检查更新
fileprivate func checkVersionByDaily(block: @escaping (() -> Void)) {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYYY-MM-dd"
    let locationStr = dateFormatter.string(from: date)
    if locationStr != UserDefaults.standard.object(forKey: "YGXCheckVersionDaily") as? String {
        block()
    }
    UserDefaults.standard.setValue(locationStr, forKey: "YGXCheckVersionDaily")
    UserDefaults.standard.synchronize()
}

fileprivate func showAlert(title: String = "检查更新", message: String, openUrl: String, isForce: Bool) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let sure = UIAlertAction(title: "更新", style: .default, handler: { (action) in
        if UIApplication.shared.canOpenURL(URL(string: openUrl)!) {
            UIApplication.shared.openURL(URL(string: openUrl)!)
        }
    })
    if !isForce {
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alert.addAction(cancel)
    }
    alert.addAction(sure)
    UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
}

extension String {
    /// 版本号变数组 "1.2.0" -> [1,2,0]
    func versionToInt() -> [Int] {
        return self.components(separatedBy: ".")
            .map { Int.init($0) ?? 0 }
    }
}
