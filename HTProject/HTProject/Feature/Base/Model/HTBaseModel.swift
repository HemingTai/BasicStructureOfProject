//
//  HTBaseModel.swift
//  HTProject
//
//  Created by Hem1ng on 2019/7/16.
//  Copyright © 2019 Hem1ngT4i. All rights reserved.
//

import UIKit
@_exported import HandyJSON

/// 基类model，包含code和message
class HTBaseModel:NSObject, HandyJSON {
    /// 返回码
    var code: HTResponseCode!
    /// 返回信息
    var message: String?
    
    required override init() {
        
    }
}

/// 返回值data为字典类型
class HTDictModel:HTBaseModel {
    var data : Dictionary<String, Any>?
    
    override var description: String {
        return "code:\(String(describing: code)), message:\(String(describing: message)), data:\(String(describing: data))"
    }
}
