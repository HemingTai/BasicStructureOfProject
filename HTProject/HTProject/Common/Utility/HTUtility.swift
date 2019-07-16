//
//  HTUtility.swift
//  HTProject
//
//  Created by Hem1ng on 2019/7/16.
//  Copyright © 2019 Hem1ngT4i. All rights reserved.
//  工具类

import UIKit
//由于命名空间存在，所以不同文件夹需要重复导入头文件，在import前加上@_exported，可实现全局导入
@_exported import MBProgressHUD
@_exported import Alamofire
@_exported import Kingfisher
@_exported import MJRefresh
@_exported import SnapKit

class HTUtility: NSObject {
    
    /// 根据时间戳获取时间字符串
    ///
    /// - Parameters:
    ///   - timestamp: 时间戳
    ///   - dateFormat: 格式
    /// - Returns: 时间字符串
    class func getTime(withTimestamp timestamp: String, dateFormat: String) -> String {
        if timestamp == "0" || timestamp.count == 0
        {
            return ""
        }
        var time: Int64 = 0
        if timestamp.count == 10 {
            time = (timestamp as NSString).longLongValue
        }
        else if timestamp.count == 13 {
            time = (timestamp as NSString).longLongValue / 1000
        }
        let date = Date(timeIntervalSince1970: TimeInterval(time))
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let strTime = formatter.string(from: date)
        return strTime
    }
    
    /// 显示Toast
    ///
    /// - Parameters:
    ///   - message: 内容
    class func showToast(with message:String) {
        let progressHUD = MBProgressHUD.showAdded(to: HT_KeyWindow!, animated: true)
        progressHUD.detailsLabel.text = message
        progressHUD.detailsLabel.font = UIFont.boldSystemFont(ofSize: 14)
        progressHUD.mode = .text
        progressHUD.hide(animated: true, afterDelay: 2)
        progressHUD.removeFromSuperViewOnHide = true
    }
    
    /// 显示加载标识
    ///
    /// - Parameters:
    ///   - message: 显示的内容
    class func showLoadingHUD(with message: String?) {
        let progressHUD = MBProgressHUD.showAdded(to: HT_KeyWindow!, animated: true)
        progressHUD.mode = .indeterminate
        progressHUD.label.text = message
    }
    
    /// 隐藏加载标识
    class func hideLoadingHUD() {
        MBProgressHUD.hide(for: HT_KeyWindow!, animated: true)
    }
    
    /// 比较版本是否相同
    ///
    /// - Parameter newVersion: 新版本号
    /// - Returns: 比较结果
    class func checkAppVersion(newVersion: String) -> Bool {
        if newVersion.compare(HT_AppVersion) == .orderedDescending {
            return true
        }
        return false
    }
    
    /// 网络连接检测
    class func checkNetworkConnectionIsAvailable() {
        let manager = NetworkReachabilityManager(host: "www.baidu.com")
        manager?.listener = { status in
            if status == NetworkReachabilityManager.NetworkReachabilityStatus.notReachable {
                HTUtility.showToast(with: "网络未连接！")
            }
        }
        manager?.startListening()
    }
    
    /// json格式化
    class func jsonFormat(with dic:Dictionary<String,Any>) -> String {
        let data = (try? JSONSerialization.data(withJSONObject: dic, options: []))!
        return String(data: data, encoding: .utf8) ?? ""
    }
    
    /// 清除用户数据
    class func clearUserData() {
        UserDefaults.standard.removeObject(forKey: HT_Key_Token)
        UserDefaults.standard.removeObject(forKey: HT_Key_Username)
        UserDefaults.standard.removeObject(forKey: HT_Key_HistoryRecord)
        UserDefaults.standard.synchronize()
    }
    
    /// 加载nib文件
    ///
    /// - Parameter name: 文件名
    class func loadNibFile(withNibName name: String) -> UIView {
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as! UIView
    }
    
    /// 初始化自定义下拉刷新动画视图
    ///
    /// - Parameter tableView: 列表
    /// - Parameter refreshClouser: 进入刷新状态会调用该闭包
    class func initializeCustomGifHeader(for tableView: UITableView, with refreshClouser: @escaping (() -> Void)) {
        let header = MJRefreshGifHeader(refreshingBlock: refreshClouser)
        //设置闲置时的图片
        header?.setImages([UIImage(named: "loading_letgo2")!], for: .idle)
        //设置下拉时的图片
        header?.setImages([UIImage(named: "loading_letgo1")!], for: .pulling)
        var refreshImagesArray: [Any] = []
        for i in 2...26 {
            refreshImagesArray.append(UIImage(named:String(format: "loading_coin%d", i))!)
        }
        //设置刷新时的图片
        header?.setImages(refreshImagesArray, for: .refreshing)
        header?.setTitle("下拉刷新", for: .idle)
        header?.setTitle("松开刷新", for: .pulling)
        header?.setTitle("正在刷新", for: .refreshing)
        tableView.mj_header = header
    }
    
    /// 初始化自定义上拉加载底部动画视图
    ///
    /// - Parameter tableView: 列表
    /// - Parameter loadingClouser: 进入加载状态会调用该闭包
    class func initializeCustomGifFooter(for tableView: UITableView, with loadingClouser: @escaping (() -> Void)) {
        let footer = MJRefreshAutoGifFooter(refreshingBlock: loadingClouser)
        var loadImagesArray: [Any] = []
        footer?.setImages([UIImage(named: "loading_letgo1")!], for: .idle)
        footer?.setImages([UIImage(named: "loading_letgo2")!], for: .pulling)
        for i in 1...14 {
            loadImagesArray.append(UIImage(named:String(format: "loading_rabbit%d", i))!)
        }
        //设置加载时的图片
        footer?.setImages(loadImagesArray, for: .refreshing)
        footer?.setTitle("上拉加载", for: .idle)
        footer?.setTitle("松开加载", for: .pulling)
        footer?.setTitle("正在加载", for: .refreshing)
        footer?.isOnlyRefreshPerDrag = true
        tableView.mj_footer = footer
    }
    
    /// 重置无数据加载视图
    ///
    /// - Parameter tableView: 列表
    class func resetNoMoreDataFooterView(for tableView: UITableView) {
        (tableView.mj_footer as! MJRefreshAutoGifFooter).setTitle("我的底线被你看到啦~", for: .noMoreData)
        (tableView.mj_footer as! MJRefreshAutoGifFooter).stateLabel.textColor = HT_Color_000000
        (tableView.mj_footer as! MJRefreshAutoGifFooter).stateLabel.font = UIFont.systemFont(ofSize: 12)
        (tableView.mj_footer as! MJRefreshAutoGifFooter).endRefreshingWithNoMoreData()
    }
    
    /// 初始化列表视图
    ///
    /// - Parameters:
    ///   - viewController: 当前控制器
    class func initializeTableView(for viewController: UIViewController) -> UITableView {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = HT_Color_FFFFFF
        tableView.showsHorizontalScrollIndicator = false
        viewController.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(viewController.view);
        }
        return tableView
    }
    
    /// 初始化section头视图
    class func initializeSectionHeaderView(withHeight height: CGFloat) -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: HT_Device_Width, height: height))
        header.backgroundColor = HT_Color_FFFFFF
        return header
    }

    /// 添加导航按钮
    ///
    /// - Parameters:
    ///   - viewcontroller: 当前控制器
    ///   - left: true: 添加在导航栏左边, false: 添加在导航栏右边
    ///   - frame: 坐标
    ///   - title: 标题
    ///   - font: 字体大小
    ///   - color: 颜色
    ///   - action: 点击事件
    class func addBarButtonItem(for viewController: UIViewController,left: Bool, frame: CGRect, title: String?, font: CGFloat?, color: String?, image: String?, action: Selector) {
        let btn = UIButton.initializeButton(withFrame: frame, title: title, font: font, color: color, imgName: image)
        btn.addTarget(viewController, action: action, for: .touchUpInside)
        let item = UIBarButtonItem(customView: btn)
        if left {
            if image != nil {
                btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)
            }
            viewController.navigationItem.leftBarButtonItem = item
        }
        else {
            viewController.navigationItem.rightBarButtonItem = item
        }
    }
}
