//
//  BaseViewController.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit

/// toast提示类型
enum MessageType: Int {
    ///默认提示
    case MessageTypeDefault = 0
    ///成功提示
    case MessageTypeSuccess = 1
    ///失败提示
    case MessageTypeFaild   = 2
    ///一般性消息提示
    case MessageTypeInfo    = 3
}

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()

        
        getMethodList()
        getVarList()
    }

    deinit {
        PrintLog.info("当前返回的页面: \(self.className)")
    }
    
    /// 添加UI
    func setupUI() {

    }
    
    /// 添加布局
    func setupConstraints() {

    }
}

//MARK: - 设置导航栏左右按钮
extension BaseViewController {
    
    /// 设置导航栏右边按钮
    /// - Parameters:
    ///   - image: 图片
    ///   - title: 文字
    /// - Returns: 按钮
    public func showRightButton(_ image: UIImage? = nil, _ title: String? = nil) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 32)
        if let image = image {
            button.setImage(image, for: .normal)
        }

        if let title = title {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
        }

        button.addTarget(self, action: #selector(onRightNavClick(button:)), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)

        return button
    }
    
    /// 设置导航栏左边按钮
    /// - Parameters:
    ///   - image: 图片
    ///   - title: 文字
    public func showBackButton(_ image: UIImage? = nil, _ title: String? = nil) {
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect(x: 0, y: 0, width: 70, height: 32)
        if let image = image {
            backBtn.setImage(image, for: .normal)
        }

        if let title = title {
            backBtn.setTitle(title, for: .normal)
            backBtn.setTitleColor(.white, for: .normal)
            backBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        }

        backBtn.addTarget(self, action: #selector(onLeftNavClick), for: .touchUpInside)
        backBtn.contentHorizontalAlignment = .left
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }

    
    /// 返回上一层控制器
    @objc open func onLeftNavClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    /// 右边按钮点击事件
    /// - Parameter button: button description
    @objc open func onRightNavClick(button: UIButton) {

    }
}
//MARK: - 设置页面toast
extension BaseViewController {
    
    /// 展示toast
    /// - Parameters:
    ///   - message: 内容
    ///   - messageType: 类型
    func showToast(with message: String? = nil, messageType: MessageType? = nil) {
        
    }
}

extension BaseViewController {
    
    /// 类方法进行决议
    /// - Parameter sel: 方法
    /// - Returns: description
    override class func resolveClassMethod(_ sel: Selector!) -> Bool {
        //1.匹配方法
//        
//        class_getClassMethod(<#T##cls: AnyClass?##AnyClass?#>, <#T##name: Selector##Selector#>)
//        
//        class_getInstanceMethod(<#T##cls: AnyClass?##AnyClass?#>, <#T##name: Selector##Selector#>)
                
        
        let methodName = NSStringFromSelector(sel)
        
        if methodName == "sendMessage" {
            return class_addMethod(self, sel, instanceMethod(for: sel), "v@:")
        }
        return  false;
    }
    
    /// 对象方法进行决议
    /// - Parameter sel: 方法
    /// - Returns: description
    override class func resolveInstanceMethod(_ sel: Selector!) -> Bool {
        return false
    }
    
    
    //MARK: -  快速转发 - 直接指向方法
    override class func forwardingTarget(for aSelector: Selector!) -> Any? {
        let methodName = NSStringFromSelector(aSelector)
        
        if methodName == "sendMessage" {
//            sendMessage("快速转发")
        }
        
        return [super .forwardingTarget(for: aSelector)]
    }
    
    
    //MARK: - 慢速转发
    //1.方法签名
    //2.消息转发
    
    override class func doesNotRecognizeSelector(_ aSelector: Selector!) {
        NSLog("找不到方法");
    }
    
    
}

//MARK: - 获取并打印方法 and 获取并打印属性
extension BaseViewController {
    
    func getMethodList() {
       
        var m_count: UInt32 = 0
        
        if let methods = class_copyMethodList(type(of: self), &m_count) {
            
            debugPrint(methods)
            
            for i in 0..<m_count {
                let m = methods[Int(i)]
                let sel = method_getName(m)
                let name = sel_getName(sel)
                
                debugPrint("方法: \(name): \(NSStringFromSelector(sel))")
                
            }
        }
    }
    
    func getVarList() {
        
        var p_count: UInt32 = 0
        
        if let propertys = class_copyPropertyList(type(of: self), &p_count) {
            for i in 0..<p_count{
                let p = propertys[Int(i)];
                let name = ivar_getName(p);
                debugPrint("成员变量:\(String(describing: name)): \(String(cString:property_getName(p)))");
            }
        }
        
    }
}


extension BaseViewController {
    
    private struct AssociatedKey {
        
        static let isshow = "isshow"
    }
    
    var isShow: Bool? {
        set {
            objc_setAssociatedObject(self, AssociatedKey.isshow, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        
        get {
            return objc_getAssociatedObject(self, AssociatedKey.isshow) as? Bool
        }
    }
    
    
}

extension BaseViewController {
    
    
    func aa() {
            
        method(for: Selector("aa"))
        
        

    }
    
}
