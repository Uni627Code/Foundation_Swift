//
//  BaseViewController.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit
import SwiftyColor

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()

    }

    deinit {
        PrintLog.info("lifecycler DEINIT: \(self.className)")
    }
    
    func setupUI() {

    }

    func setupConstraints() {

    }
}

//MARK: - 左右按钮
extension BaseViewController {
    public func showRightButton(_ image: UIImage? = nil, _ title: String? = nil) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 32)
        if let image = image {
            button.setImage(image, for: .normal)
        }

        if let title = title {
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitle(title, for: .normal)
            button.setTitleColor(0x4856E9.color, for: .normal)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: -5)
        }

        button.addTarget(self, action: #selector(onRightNavClick(button:)), for: .touchUpInside)
        button.contentHorizontalAlignment = .right
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)

        return button
    }

    @objc open func onRightNavClick(button: UIButton) {

    }

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

    //返回上一层控制器
    @objc open func onLeftNavClick() {
        self.navigationController?.popViewController(animated: true)
    }
}
