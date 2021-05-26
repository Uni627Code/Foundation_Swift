//
//  UIScrollView+Extension.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import MJRefresh

@objc public protocol RefreshDelegate: class {
    @objc optional func loadData()
    @objc optional func loadMoreData()
}


public extension UIScrollView {

    private struct AssociatedKeys {
        static var freshKey = "UIScrollView.refresh.type"
        static var freshDelegateKey = "UIScrollView.refresh.delegate"
    }

    weak var refreshDelegate: RefreshDelegate? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.freshDelegateKey) as? RefreshDelegate
        }

        set (delegate) {
            objc_setAssociatedObject(self, &AssociatedKeys.freshDelegateKey, delegate, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

    var refreshType: RefreshType {

        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.freshKey) as? RefreshType) ?? .none
        }

        set (type) {
            switch type {
            case .none:
                self.mj_footer = nil
                self.mj_header = nil
            case .header:
                self.mj_footer = nil
                self.mj_header = ERefresh.header
                guard let header = self.mj_header else {
                    return
                }
                header.refreshingBlock = {[weak self] in
                    if let strongSelf = self {
                        if let delegate = strongSelf.refreshDelegate {
                            delegate.loadData?()
                        }
                    }
                }
            case .footer:
                self.mj_footer = ERefresh.footer
                guard let footer = self.mj_footer else {
                    return
                }
                footer.refreshingBlock = {[weak self] in
                    if let strongSelf = self {
                        strongSelf.refreshDelegate?.loadMoreData?()
                    }
                }
                self.mj_header = nil
            case .all:
                self.mj_footer = ERefresh.footer
                guard let footer = self.mj_footer else {
                    return
                }
                footer.refreshingBlock = {[weak self] in
                    if let strongSelf = self {
                        strongSelf.refreshDelegate?.loadMoreData?()
                    }
                }
                self.mj_header = ERefresh.header
                guard let header = self.mj_header else {
                    return
                }
                header.refreshingBlock = {[weak self] in
                    if let strongSelf = self {
                        strongSelf.refreshDelegate?.loadData?()
                    }
                }
            }

            objc_setAssociatedObject(self, &AssociatedKeys.freshKey, type, .OBJC_ASSOCIATION_ASSIGN)
        }
    }

}
