//
//  UIKit+Extension.swift
//  HTProject
//
//  Created by Hem1ng on 2019/7/16.
//  Copyright © 2019 Hem1ngT4i. All rights reserved.
//  控件扩展类

import UIKit

extension UIView {
    
    /// 创建View
    ///
    /// - Parameters:
    ///   - frame: 尺寸位置
    ///   - bgColor: 背景颜色
    class func initializeView(withFrame frame: CGRect, bgColor: String?, alpha: CGFloat?) -> UIView {
        let view = UIView(frame: frame)
        if let nBgColor = bgColor {
            if let nAlpha = alpha {
                view.backgroundColor = UIColor.getColor(fromHexColorString: nBgColor, alpha: nAlpha)
                return view
            }
            view.backgroundColor = UIColor.getColor(fromHexColorString: nBgColor)
        }
        return view
    }
}

extension UIButton {
    
    /// 创建button
    ///
    /// - Parameters:
    ///   - frame: 尺寸位置
    ///   - title: 文字
    ///   - font: 字号
    ///   - imgName: 图片名
    class func initializeButton(withFrame frame: CGRect, title: String?, font: CGFloat?, color: String?, imgName: String?) -> UIButton {
        let btn = UIButton(type: .custom)
        btn.frame = frame
        btn.titleLabel?.textAlignment = .center
        if let nTitle = title { btn.setTitle(nTitle, for: .normal) }
        if font != nil { btn.titleLabel?.font = UIFont.systemFont(ofSize: font!) }
        if let nColor = color { btn.setTitleColor(UIColor.getColor(fromHexColorString: nColor), for: .normal) }
        if let nImgName = imgName { btn.setImage(UIImage(named: nImgName)?.withRenderingMode(.alwaysOriginal), for: .normal) }
        return btn
    }
}

extension UILabel {
    
    /// 创建label
    ///
    /// - Parameters:
    ///   - frame: 尺寸位置
    ///   - text: 文字
    ///   - font: 字号
    ///   - color: 颜色
    class func initializeLabel(withFrame frame: CGRect, text: String?, font: CGFloat?, color: String?) -> UILabel {
        let label = UILabel(frame: frame)
        label.textAlignment = .center
        if let nText = text { label.text = nText }
        if let nFont = font { label.font = UIFont.systemFont(ofSize: nFont) }
        if let nColor = color { label.textColor = UIColor.getColor(fromHexColorString: nColor) }
        return label
    }
}

extension UIImageView {
    
    /// 创建imageView
    ///
    /// - Parameters:
    ///   - frame: 尺寸位置
    ///   - bgColor: 颜色
    ///   - imageName: 图片名
    class func initializeImageView(withFrame frame: CGRect, bgColor:String?, imageName: String?) -> UIView {
        let imgView = UIImageView(frame: frame)
        if let nBgColor = bgColor { imgView.backgroundColor = UIColor.getColor(fromHexColorString: nBgColor) }
        if let nImgName = imageName { imgView.image = UIImage(named: nImgName) }
        return imgView
    }
}

extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone Xs"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "i386", "x86_64":                          return "Simulator"
            default:                                        return identifier
        }
    }
}
