//
//  UIViewController+Extension.swift
//  HTProject
//
//  Created by Hem1ng on 2019/7/16.
//  Copyright © 2019 Hem1ngT4i. All rights reserved.
//  控制器扩展类

import UIKit

extension UIViewController {
    
    /// 显示导航栏
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /// 隐藏导航栏
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    /// 返回前一页
    func popViewController() {
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 返回指定页
    func pop(to viewController: UIViewController) {
        self.navigationController?.popToViewController(viewController, animated: true)
    }
    
    /// 推到下一页
    ///
    /// - Parameter vc: 将要推到的页面
    func push(viewController vc: UIViewController, title: String?) {
        if let nTitle = title {
            vc.navigationItem.title = nTitle
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 推到H5网页
    ///
    /// - Parameters:
    ///   - type: 网页类型，GJWebType的枚举值
    ///   - param: 参数[key:value]格式,必须包含url:链接地址
    func pushToWebViewController(with type:HTWebType, param: Dictionary<String, Any>) {
        let vc = HTBaseWebViewController()
        vc.type = type
        vc.param = param
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 弹出登录页
    func presentLoginViewController() {
        //修改登录页的类
        self.present(HTBaseViewController(), animated: true, completion: nil)
    }
    
    /// 获取当前窗口最上层控制器
    ///
    /// - Returns: viewController
    class func currentViewController() -> UIViewController {
        var rootViewController = HT_AppDelegate.window?.rootViewController
        while rootViewController?.presentedViewController != nil {
            rootViewController = rootViewController?.presentedViewController
        }
        return rootViewController!
    }
}
