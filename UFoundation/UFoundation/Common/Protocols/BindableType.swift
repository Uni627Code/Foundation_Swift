//
//  BindableType.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit


protocol BindableType {
    //关联类型
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }

    func bindViewModel()

}

extension BindableType where Self: UIViewController {

    //使用 mutating 关键字修饰方法是为了能在该方法中修改 struct 或是 enum 的变量，在设计接口的时候，也要考虑到使用者程序的扩展性。所以要多考虑使用mutating来修饰方法。

    mutating func bind(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}

extension BindableType where Self: UITableViewCell {

    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }

}

extension BindableType where Self: UICollectionViewCell {

    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }

}

extension BindableType where Self: UIView {

    mutating func bind(to viewModel: Self.ViewModelType) {
        self.viewModel = viewModel
        bindViewModel()
    }

}
