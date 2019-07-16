//
//  HTConfiguration.swift
//  HTProject
//
//  Created by Hem1ng on 2019/7/16.
//  Copyright © 2019 Hem1ngT4i. All rights reserved.
//  配置信息类

import UIKit

//MARK: ====== SEVERADDRESS ======

/// 测试服务器
let HT_SEVERADDRESS = ""
/// 生产服务器
// let HT_SEVERADDRESS  = ""

//MARK: ====== API ======

/// 版本更新
let HT_API_000001   = ""

//MARK: ====== SNAPSHOT ======

/// 获取主窗口
let HT_KeyWindow = UIApplication.shared.keyWindow
/// 获取主屏幕宽度
let HT_Device_Width = UIScreen.main.bounds.size.width
/// 获取主屏幕高度
let HT_Device_Height = UIScreen.main.bounds.size.height
/// 判断当前设备是否是iPhoneSE
let HT_Device_iPhoneSE = UIScreen.main.bounds.size.height == 568 ? true : false
/// 判断当前设备是否是iPhone8
let HT_Device_iPhone8 = UIScreen.main.bounds.size.height == 667 ? true : false
/// 判断当前设备是否是iPhone8 Plus
let HT_Device_iPhone8_Plus = UIScreen.main.bounds.size.height == 736 ? true : false
/// 判断当前设备是否是iPhoneX系列
let HT_Device_iPhoneX_Serise = UIScreen.main.bounds.size.height >= 812 ? true : false
/// 判断当前手机系统版本是否是9.0以上
let HT_iOS_9 = (UIDevice.current.systemVersion as NSString).floatValue >= 9.0 ? true : false
/// 判断当前手机系统版本是否是10.0以上
let HT_iOS_10 = (UIDevice.current.systemVersion as NSString).floatValue >= 10.0 ? true : false
/// 判断当前手机系统版本是否是11.0以上
let HT_iOS_11 = (UIDevice.current.systemVersion as NSString).floatValue >= 11.0 ? true : false
//iphone X系列判断
func isIphoneXSeries() -> Bool {
    var iphoneXSeries: Bool = false
    if UIDevice.current.userInterfaceIdiom != UIUserInterfaceIdiom.phone {
        return iphoneXSeries
    }
    if #available(iOS 11, *) {
        if KWindow.safeAreaInsets.bottom > 0.0 {
            iphoneXSeries = true
        }
    }
    return iphoneXSeries
}
let StatusBarHeight = isIphoneXSeries() ? 44.0:20.0 as CGFloat
let NavigationBarHeight = isIphoneXSeries() ? 88.0 : 64.0 as CGFloat
let  BottomSafeHeight = isIphoneXSeries() ? 34.0 : 0.0 as CGFloat

func colorWithHexString(hex: String) -> UIColor {
    var cString = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    if (cString.hasPrefix("#")) {
        let index = cString.index(cString.startIndex, offsetBy: 1)
        cString = String(cString[index...])
    }
    if (cString.count != 6) {
        return UIColor.red
    }
    let rIndex = cString.index(cString.startIndex, offsetBy: 2)
    let rString = String(cString[..<rIndex])
    let otherString = String(cString[rIndex...])
    let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
    let gString = String(otherString[..<gIndex])
    let bIndex = cString.index(cString.endIndex, offsetBy: -2)
    let bString = String(cString[bIndex...])
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
    Scanner(string: rString).scanHexInt32(&r)
    Scanner(string: gString).scanHexInt32(&g)
    Scanner(string: bString).scanHexInt32(&b)
    return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
}

/// 获取设备唯一标识符（该标识符在App删除后重新安装是会改变的，并不是实际意义上的唯一标识符）
let HT_Device_UUID = UIDevice.current.identifierForVendor?.uuidString
/// 获取AppDelegate
let HT_AppDelegate = UIApplication.shared.delegate as! AppDelegate
/// 获取手机版本号
let HT_Mobile_OS = Bundle.main.object(forInfoDictionaryKey: "DTPlatformVersion") as! String
/// 获取当前App名称
let HT_AppName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
/// 获取当前App版本号
let HT_AppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

//MARK: ====== COLOR ======

let HT_Color_000000 = UIColor.getColor(fromHexColorString: "000000")
let HT_Color_3C4669 = UIColor.getColor(fromHexColorString: "3C4669")
let HT_Color_50597B = UIColor.getColor(fromHexColorString: "50597B")
let HT_Color_9EB2CD = UIColor.getColor(fromHexColorString: "9EB2CD")
let HT_Color_BEC8DC = UIColor.getColor(fromHexColorString: "BEC8DC")
let HT_Color_CCCCCC = UIColor.getColor(fromHexColorString: "CCCCCC")
let HT_Color_F4F4F4 = UIColor.getColor(fromHexColorString: "F4F4F4")
let HT_Color_FFFFFF = UIColor.getColor(fromHexColorString: "FFFFFF")

//MARK: ====== USERDEFAULTS ======

/// 版本号
let HT_Key_AppVersion     = "HTAppVersion"
/// 是否已安装
let HT_Key_Installed      = "HTInstalled"
/// 登录token
let HT_Key_Token          = "HTToken"
/// 请求头鉴权
let HT_Key_Authorization  = "HTAuthorization"
/// 用户名
let HT_Key_Username       = "HTUsername"
/// 历史记录
let HT_Key_HistoryRecord  = "HTHistoryRecord"
/// 设备号
let HT_Key_DeviceToken    = "HTDeviceToken"
/// 记住登录状态flag
let HT_Key_RememberFlag   = "HTRememberFlag"
/// 服务器地址
let HT_Key_SeverAddress   = "HTSeverAddress"

//MARK: ====== NOTIFICATION ======

/// 更新列表
let HT_Notification_Name_UpdateList = "UpdateList"

//MARK: ====== URL ======

/// AppStore链接
let HT_AppStore_Url = ""

//MARK: ====== CONST ======

/// 没有网络提示语
let HT_Message_BadNetwork = "网络不给力\n请检查后重试"




