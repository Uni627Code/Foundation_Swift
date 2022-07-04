//
//  EWebViewController.swift
//  EUI
//
//  Created by LynnCheng on 2019/10/22.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import UIKit
import WebKit
 
class EWebViewController: BaseViewController {

    public var url: String?
    
    public var html:String?

    lazy var progressView: UIProgressView = {
        let progress = UIProgressView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 1))
        progress.progressTintColor = UIColor.orange
        progress.trackTintColor = .clear
        return progress
    }()
        
    lazy var webView: WKWebView = {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: self.view.frame.height), configuration: self.config)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        return webView
    }()
        
    ///创建网页配置对象
    lazy var config: WKWebViewConfiguration = {
        let config = WKWebViewConfiguration.init()
        // 创建设置对象
        let preference = WKPreferences.init()
        //最小字体大小 当将javaScriptEnabled属性设置为NO时，可以看到明显的效果
        preference.minimumFontSize = 0;
        //设置是否支持javaScript 默认是支持的
        preference.javaScriptEnabled = true;
        // 在iOS上默认为NO，表示是否允许不经过用户交互由javaScript自动打开窗口
        preference.javaScriptCanOpenWindowsAutomatically = true;
        config.preferences = preference;
            
        config.allowsInlineMediaPlayback = true // 支持h5 播放
        config.suppressesIncrementalRendering = true // webView 一次性加载，没读取完成就不加载
            
        //设置是否允许画中画技术 在特定设备上有效
        config.allowsPictureInPictureMediaPlayback = true;
        //设置请求的User-Agent信息中应用程序名称 iOS9后可用
        config.applicationNameForUserAgent = "ChinaDailyForiPad";
            
        let jSString = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);"
            
        let wkUserScript = WKUserScript(source: jSString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
            
        //这个类主要用来做native与JavaScript的交互管理
        let wkUController = WKUserContentController.init()
            
        wkUController.addUserScript(wkUserScript)
        config.userContentController = wkUController
        return config
    }()

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.webView)
        self.view.addSubview(self.progressView)
        self.webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        
        if let url = url {
            guard let NetURL = URL(string: url) else {
                return
            }
            let requst = NSURLRequest(url: NetURL)
            webView.load(requst as URLRequest)
        }
        
        if let html = html {
            webView.loadHTMLString(html, baseURL: nil)
        }
    }
 
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            self.progressView.progress = Float(self.webView.estimatedProgress)
    }
        
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}

extension EWebViewController:WKNavigationDelegate,WKUIDelegate{
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        // 在JS端调用alert函数时，会触发此代理方法。
        // JS端调用alert时所传的数据可以通过message拿到
        // 在原生得到结果后，需要回调JS，是通过completionHandler回调
        let alertView = UIAlertController.init(title: "提示", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.destructive) { (action:UIAlertAction) in
            //确定
            completionHandler()
        }
        alertView.addAction(okAction)
    }
        
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        // JS端调用confirm函数时，会触发此方法
        // 通过message可以拿到JS端所传的数据
        // 在iOS端显示原生alert得到YES/NO后
        // 通过completionHandler回调给JS端
        let alertView = UIAlertController.init(title: "提示", message:message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel) { (action:UIAlertAction) in
            //取消
            completionHandler(false)
        }
        alertView.addAction(cancelAction)
        let okAction = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.default) { (action:UIAlertAction) in
            //确定
            completionHandler(true)
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }
        
    public func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        // JS端调用prompt函数时，会触发此方法
        // 要求输入一段文本
        // 在原生输入得到文本内容后，通过completionHandler回调给JS
        let alertTextField = UIAlertController.init(title: "请输入", message: "JS调用输入框", preferredStyle: UIAlertController.Style.alert)
        alertTextField.addTextField { (textField:UITextField) in
            //设置textField相关属性
            textField.textColor = UIColor.red
        }
        let okAction = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.destructive) { (action:UIAlertAction) in
            //确定
            completionHandler(alertTextField.textFields?.last?.text)
        }
        alertTextField.addAction(okAction)
        self.present(alertTextField, animated: true, completion: nil)
    }
        
    //MARK:-WKNavigationDelegate
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //页面开始加载，可在这里给用户loading提示
            
        self.navigationItem.title = "加载中..."
        /// 获取网页的progress
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = Float(self.webView.estimatedProgress)
        }
    }
        
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //内容开始到达时
    }
        
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //页面加载完成时
        /// 获取网页title
        self.title = self.webView.title
            
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 1.0
            self.progressView.isHidden = true
        }
    }
        
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //页面加载出错，可在这里给用户错误提示
        UIView.animate(withDuration: 0.5) {
            self.progressView.progress = 0.0
            self.progressView.isHidden = true
        }
        /// 弹出提示框点击确定返回
        let alertView = UIAlertController.init(title: "提示", message: "加载失败", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title:"确定", style: .default) { okAction in
            _=self.navigationController?.popViewController(animated: true)
        }
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
            
    }
        
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        //收到服务器重定向请求
    }
        
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // 在请求开始加载之前调用，决定是否跳转
        decisionHandler(WKNavigationActionPolicy.allow)
    }
        
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        //在收到响应开始加载后，决定是否跳转
        decisionHandler(WKNavigationResponsePolicy.allow)
    }
        
    //MARK:-WKScriptMessageHandler
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        //h5给端传值的内容，可在这里实现h5与原生的交互时间
        let messageDic = message.body
        print(messageDic)
    }
}
