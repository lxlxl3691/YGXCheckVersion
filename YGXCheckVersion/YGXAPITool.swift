//
//  YGXAPITool.swift
//  YGXCheckVersionDemo
//
//  Created by michael 伊 on 2018/5/30.
//  Copyright © 2018年 michael 伊. All rights reserved.
//

import Foundation

typealias callbackfunc = (_ result: [String: Any]) -> Void
typealias faildBlock = (_ error: Error?) -> Void

class YGXAPITool: NSObject {
    static let share = YGXAPITool()
    func postWithPath(baseUrl: String = Environment.appStore.rawValue, path: String, paras: Dictionary<String,Any>, success: @escaping callbackfunc, failure: @escaping faildBlock) {
        var i = 0
        var address = baseUrl + path
        
        if !(paras.isEmpty) {
            address += "?"
        }
        //        if let paras = paras {
        for (key,value) in paras {
            if i == 0 {
                address += "\(key)=\(value)"
            }
            else {
                address += "&\(key)=\(value)"
            }
            i += 1
        }
        //        }
        let url = URL(string: address)
        var request = URLRequest.init(url: url!)
        request.httpMethod = "POST"
        request.httpBody = address.data(using: .utf8)
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, respond, error) in
            if let result = try? JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as? [String : Any] {
                success(result!)
            }
            else {
                failure(error!)
            }
        }
        dataTask.resume()
    }
}
