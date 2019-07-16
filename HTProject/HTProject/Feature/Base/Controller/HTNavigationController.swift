//
//  HTNavigationController.swift
//  HTProject
//
//  Created by Hem1ng on 2019/7/16.
//  Copyright © 2019 Hem1ngT4i. All rights reserved.
//  自定义导航控制器

import UIKit

class HTNavigationController: UINavigationController {
    
    /// 返回按钮
    lazy var backItem: UIBarButtonItem = {
        let backBtn = UIButton.initializeButton(withFrame: CGRect(x: 0, y: 0, width: 30, height: 40), title: nil, font: nil, color: nil, imgName: "")
        backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        backBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -24, bottom: 0, right: 0)
        return UIBarButtonItem(customView: backBtn)
    }()
    
    //MARK: ---------- LifeCycle ----------
    
    override func loadView() {
        super.loadView()
        //设置导航栏背景图片，阴影分割线，并设置title字体和颜色
        self.navigationBar.setBackgroundImage(UIImage.getImage(fromColor: HT_Color_50597B), for: .default)
        self.navigationBar.isTranslucent = false
        self.navigationBar.titleTextAttributes = [NSMutableAttributedString.Key.font: UIFont.systemFont(ofSize: 18), NSMutableAttributedString.Key.foregroundColor: HT_Color_BEC8DC]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.responds(to: #selector(getter: UINavigationController.interactivePopGestureRecognizer)) {
            self.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    //MARK: ---------- CustomizeFuntions ----------
    
    @objc func backAction() {
        self.popViewController(animated: true)
    }
    
    //MARK: ---------- overrideFuntions ----------
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        //推下一页时的导航栏左侧按钮显示为返回按钮
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = backItem
        }
        super.pushViewController(viewController, animated: animated)
    }
}

extension HTNavigationController: UIGestureRecognizerDelegate {
    
    /// 重写侧滑手势
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            return self.viewControllers.count > 1
        }
        return true
    }
}
