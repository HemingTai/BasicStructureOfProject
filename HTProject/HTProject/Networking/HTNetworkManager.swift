//
//  HTNetworkManager.swift
//  HTProject
//
//  Created by Hem1ng on 2019/7/16.
//  Copyright © 2019 Hem1ngT4i. All rights reserved.
//

import Foundation

typealias successClosure = (Dictionary<String, Any>) -> Void
typealias failureClosure = (Error) -> Void
typealias dataModelClosure<T:HandyJSON> = (T) -> Void

/// 更改请求头
fileprivate class HTRequestAdapter: RequestAdapter {
    var addtionalHeader = ["Authorization": UserDefaults.standard.value(forKey: HT_Key_Authorization)]
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue(addtionalHeader["Authorization"] as? String, forHTTPHeaderField: "Authorization")
        return urlRequest
    }
}

class HTNetworkManager: SessionManager {
    static let shared = customizeConfiguration()
    
    /// 自定义配置
    class fileprivate func customizeConfiguration() -> SessionManager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 60
        let manager = Alamofire.SessionManager(configuration: configuration)
        manager.adapter = HTRequestAdapter()
        return manager
    }
    
    /// get方式请求
    ///
    /// - Parameters:
    ///   - api: 接口地址
    ///   - successClosure: 成功回调
    ///   - failureClosure: 失败回调
    class func requestData_Get(withApi api: String, parameters:Dictionary<String, Any>?, successClosure: @escaping successClosure, failureClosure: @escaping failureClosure) {
        HTNetworkManager.shared.request(HT_SEVERADDRESS + api, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                successClosure(data as! Dictionary<String, Any>)
            case .failure(let error):
                failureClosure(error)
            }
        }
    }
    
    /// post方式请求
    ///
    /// - Parameters:
    ///   - api: 接口地址
    ///   - parameters: 参数
    ///   - successClosure: 成功回调
    ///   - failureClosure: 失败回调
    class func requestData_Post(withApi api: String, parameters:Dictionary<String, Any>?, successClosure: @escaping successClosure, failureClosure: @escaping failureClosure) {
        HTNetworkManager.shared.request(HT_SEVERADDRESS + api, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            debugPrint(response)
            switch response.result {
                case .success(let data):
                    successClosure(data as! Dictionary<String, Any>)
                case .failure(let error):
                    HTNetworkManager.handleError(with: error as! URLError)
                    failureClosure(error)
            }
        }
    }
    
    /// 处理error
    class fileprivate func handleError(with error : URLError) {
        if(error.code == .notConnectedToInternet) {
            HTUtility.showToast(with: "网络不可用，请检查网络连接")
        }
        else if (error.code == .timedOut) {
            HTUtility.showToast(with: "网络请求超时")
        }
        else if (error.code == .cannotConnectToHost) {
            HTUtility.showToast(with: "网络不可用，请检查网络连接")
        }
        else if (error.code == .badServerResponse) {
            HTUtility.showToast(with: "服务器未响应")
        }
    }
    
    /// 转换成dataModel
    ///
    /// - Parameter json: 服务端返回的json数据
    /// - Returns: model
    class func dataModel<T:HandyJSON>(with json: Dictionary<String, Any>) -> (T) {
        var model = T()
        if !json.isEmpty {
            model = T.deserialize(from: json)!
        }
        return model
    }
    
    /// 更新header
    ///
    /// - Parameter header: 待更新的header
    class func updateHttpHeader(with header:Dictionary<String,String>) {
        (HTNetworkManager.shared.adapter as! HTRequestAdapter).addtionalHeader = header
    }
}




