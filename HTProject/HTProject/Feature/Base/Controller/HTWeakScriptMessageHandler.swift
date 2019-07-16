//
//  HTWeakScriptMessageHandler.swift
//  HTProject
//
//  Created by Hem1ng on 2019/7/16.
//  Copyright © 2019 Hem1ngT4i. All rights reserved.
//

import Foundation
@_exported import WebKit

class HTWeakScriptMessageHandler: NSObject, WKScriptMessageHandler {
    
    weak var delegate: WKScriptMessageHandler?
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if delegate != nil {
            delegate!.userContentController(userContentController, didReceive: message)
        }
    }
}
