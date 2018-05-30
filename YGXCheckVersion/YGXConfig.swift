//
//  YGXConfig.swift
//  YGXCheckVersionDemo
//
//  Created by michael 伊 on 2018/5/30.
//  Copyright © 2018年 michael 伊. All rights reserved.
//

import Foundation

enum Environment: String {
    case appStore = "http://itunes.apple.com/"
    //    case ucfPay = "https://ipay.ucfpay.com/bizpay-api/api/"
}

enum UrlPath: String {
    case store = "lookup"
}
struct systemData {
    static let infoDict = Bundle.main.infoDictionary!
    static let curBundleId = systemData.infoDict["CFBundleIdentifier"] as! String
    static let curVer = systemData.infoDict["CFBundleShortVersionString"] as! String
}

struct appStoreData {
    static let params = ["bundleId":systemData.curBundleId,
                         "country" :"cn"]
}
