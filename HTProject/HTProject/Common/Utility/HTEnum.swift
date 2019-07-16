//
//  HTEnum.swift
//  HTProject
//
//  Created by Hem1ng on 2019/7/16.
//  Copyright © 2019 Hem1ngT4i. All rights reserved.
//  枚举

/// 返回码
enum HTResponseCode:Int {
    /// 成功
    case success = 200
    /// 失败
    case failure = 201
    /// 资源未找到
    case notFound = 404
    /// 服务器内部错误
    case serverError = 500
}

/// 网页类型
enum HTWebType {
    /// 默认
    case defaultPage
    /// 登录
    case login
    /// 设置
    case setting
    ///列表
    case list
    /// 详情页
    case detail
    /// 搜索
    case search
}
