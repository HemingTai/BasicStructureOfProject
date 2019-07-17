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
let HT_Color_50597B = UIColor.getColor(fromHexColorString: "50597B")
let HT_Color_BEC8DC = UIColor.getColor(fromHexColorString: "BEC8DC")
let HT_Color_CCCCCC = UIColor.getColor(fromHexColorString: "CCCCCC")
let HT_Color_F4F4F4 = UIColor.getColor(fromHexColorString: "F4F4F4")
let HT_Color_FFFFFF = UIColor.getColor(fromHexColorString: "FFFFFF")


//MARK: ====== USERDEFAULTS ======

/// 版本号
let HT_Key_AppVersion     = "HTAppVersion"
/// 是否已安装
let HT_Key_Installed      = "HTInstalled"
/// 是否已安装
let HT_Key_Token          = "HTToken"
/// 是否已安装
let HT_Key_Authorization  = "HTAuthorization"


//MARK: ====== NOTIFICATION ======

/// 弹出登录
let HT_Notification_Name_PresentLogin = "HTPresentLogin"


//MARK: ====== URL ======

/// AppStore链接
let HT_AppStore_Url = ""


//MARK: ====== CONST ======

/// 没有网络提示语
let HT_Message_BadNetwork = "网络不给力\n请检查后重试"




