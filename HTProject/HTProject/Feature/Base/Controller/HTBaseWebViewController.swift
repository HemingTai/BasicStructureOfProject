//
//  HTBaseWebViewController.swift
//  HTProject
//
//  Created by Hem1ng on 2019/7/16.
//  Copyright © 2019 Hem1ngT4i. All rights reserved.
//  webView基类

import UIKit

class HTBaseWebViewController: HTBaseViewController {

    var webView: WKWebView?
    var progressView: UIProgressView?
    /// 网页类型，默认值
    var type: HTWebType = .defaultPage
    /// 参数[key:value]格式,必须包含url:链接地址
    var param = [String:Any]()
    
    //MARK: ---------- LifeCycle ----------
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            webView?.scrollView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    deinit {
        webView?.removeObserver(self, forKeyPath: "title")
        webView?.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    //MARK: ---------- CustomizeFuntions ----------
    
    /// 初始化子视图
    func initializeWebView(with config: WKWebViewConfiguration) {
        webView = WKWebView(frame: CGRect.zero, configuration: config)
        let scriptMessageHandler = HTWeakScriptMessageHandler()
        scriptMessageHandler.delegate = self
        //name可以自定义，只要保证H5调用的时候名称一致既可
        config.userContentController.add(scriptMessageHandler, name: "jumpToLogin")
        webView?.navigationDelegate = self
        
        self.view.addSubview(webView!)
        webView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        progressView = UIProgressView(frame: CGRect(x: 0, y: 0, width: HT_Device_Width, height: 0.5))
        progressView?.tintColor = HT_Color_CCCCCC
        progressView?.trackTintColor = HT_Color_F4F4F4
        self.view.addSubview(progressView!)
        
        if type != .list {
            webView?.addObserver(self, forKeyPath: "title", options: .new, context: nil)
            webView?.addObserver(self, forKeyPath:"estimatedProgress", options: .new, context: nil)
        }
    }
    
    /// 加载url链接
    func loadUrlRequest() {
        let request = URLRequest(url: URL(string: param["url"]! as! String)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 0)
        webView?.load(request)
    }
    
    /// 注入token
    ///
    /// - Parameter token: token字符串
    func injectLoginToken (with token:String) {
        let token = "localStorage.setItem(\"htLoginToken\",'\(token)')"
        let script = WKUserScript(source: token, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        webView?.configuration.userContentController.addUserScript(script)
    }
    
    /// 调用js方法
    ///
    /// - Parameter js: js字符串
    func excuteJavaScript(with js:String) {
        debugPrint(js)
        webView?.evaluateJavaScript(js, completionHandler: nil)
    }
    
    /// 清空缓存
    func clearCache() {
        let date:Date = Date(timeIntervalSince1970: 0)
        let types: Set = WKWebsiteDataStore.allWebsiteDataTypes()
        WKWebsiteDataStore.default().removeData(ofTypes: types, modifiedSince: date, completionHandler: {})
    }
}

extension HTBaseWebViewController: WKNavigationDelegate {
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            switch type {
                case .detail:
                    self.navigationItem.title = webView?.title
                case .defaultPage:
                    self.navigationItem.title = param["title"] as? String
                default:
                    break
            }
        } else if keyPath == "estimatedProgress" {
            progressView?.isHidden = false
            progressView?.setProgress(Float(webView!.estimatedProgress), animated: true)
            if webView!.estimatedProgress  >= 1.0 {
                progressView?.isHidden = true
                progressView?.setProgress(0.0, animated: true)
            }
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        debugPrint("start loading ...")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrint("finish loading ...")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        debugPrint("loading fail ...")
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
            decisionHandler(.cancel)
            return
        }
        decisionHandler(.allow)
    }
}

extension HTBaseWebViewController: WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch message.name {
            case "jumpToLogin":
                presentLoginViewController()
            default:
                break
        }
    }
}
