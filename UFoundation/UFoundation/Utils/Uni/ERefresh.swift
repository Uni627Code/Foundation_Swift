//
//  ERefresh.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import MJRefresh

public enum RefreshType {
    case none
    case header
    case footer
    case all
}

typealias RefreshEndBlock = ()->Void

public class ERefresh: NSObject {
    static var header:MJRefreshHeader {
        let header = MJRefreshStateHeader()
        header.setTitle("下拉可以刷新", for: .idle)
        header.setTitle("松开立即刷新", for: .pulling)
        header.setTitle("正在刷新数据中...", for: .refreshing)
        guard let stateLabel = header.stateLabel else {
            return header
        }
        stateLabel.font = UIFont.systemFont(ofSize: 14)
        stateLabel.textColor = UIColor.black
        guard let lastUpdatedTimeLabel = header.lastUpdatedTimeLabel else {
            return header
        }
        lastUpdatedTimeLabel.isHidden = true
        return header
    }

    static var footer:MJRefreshFooter {
        let footer = MJRefreshBackStateFooter()
        footer.setTitle("上拉加载更多数据", for: .idle)
        footer.setTitle("松开立即加载更多", for: .pulling)
        footer.setTitle("正在加载数据...", for: .refreshing)
        footer.setTitle("已经全部加载完毕", for: .noMoreData)
        guard let stateLabel = footer.stateLabel else {
            return footer
        }
        stateLabel.font = UIFont.systemFont(ofSize: 14)
        stateLabel.textColor = UIColor.black
        return footer
    }
}
