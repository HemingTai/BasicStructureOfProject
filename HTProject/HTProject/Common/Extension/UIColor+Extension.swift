//
//  UIColor+Extension.swift
//  HTProject
//
//  Created by Hem1ng on 2019/7/16.
//  Copyright © 2019 Hem1ngT4i. All rights reserved.
//  颜色扩展类

import UIKit

extension UIColor {
    
    /// 根据十六进制色值字符串获取颜色
    ///
    /// - Parameter hexColorString: 十六进制色值字符串
    /// - Returns: 返回color对象
    class func getColor(fromHexColorString hexColorString: String) -> UIColor {
        return getColor(fromHexColorString: hexColorString, alpha: 1.0)
    }
    
    /// 根据十六进制色值字符串和透明度获取颜色
    ///
    /// - Parameters:
    ///   - hexColorString: 十六进制色值字符串
    ///   - alpha: 透明度
    /// - Returns: 返回color对象
    class func getColor(fromHexColorString hexColorString: String, alpha: CGFloat) -> UIColor {
        var redInt: UInt32 = 0, greenInt: UInt32 = 0, blueInt: UInt32 = 0
        //范围长度为2，取红色值
        let redRange = NSRange(location: 0, length: 2)
        Scanner(string: (hexColorString as NSString).substring(with: redRange)).scanHexInt32(&redInt)
        //范围长度为2，取绿色值
        let greenRange = NSRange(location: 2, length: 2)
        Scanner(string: (hexColorString as NSString).substring(with: greenRange)).scanHexInt32(&greenInt)
        //范围长度为2，取蓝色值
        let blueRange = NSRange(location: 4, length: 2)
        Scanner(string: (hexColorString as NSString).substring(with: blueRange)).scanHexInt32(&blueInt)
        return UIColor(red: CGFloat(Float(redInt)/255.0), green: CGFloat(Float(greenInt)/255.0), blue: CGFloat(Float(blueInt)/255.0), alpha: alpha)
    }
}
