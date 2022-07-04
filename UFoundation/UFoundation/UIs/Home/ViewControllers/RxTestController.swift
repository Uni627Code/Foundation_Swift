//
//  RxTestController.swift
//  UFoundation
//  https://beeth0ven.github.io/RxSwift-Chinese-Documentation/
//  Created by 陆小懒 on 2022/4/18.
//  Copyright © 2022 Uni. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class RxTestController: UIViewController, BindableType, UIScrollViewDelegate {
    
    var viewModel: RxTestViewModel!
        
    var disposeBag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Product>>(
        configureCell: { (ds, tv, indexPath, element) in
            guard let cell = tv.dequeueReusableCell(withIdentifier: "cell") else {
                return UITableViewCell()
            }
            
            cell.textLabel?.text = element.title
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }
    )
    
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect.zero, style: .plain)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "rxswift用例"
        
        self.view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navBarHeight())
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-bottomAndSafeHeight)
        }
        
    }
    
    /// 绑定数据
    private func binding() {
        
        var array: [SectionModel<String, Product>] = []
        
        for model in viewModel.dataArray {
            
           let section = SectionModel(model: model.title, items: viewModel.dataArray)
            array.append(section)
        }
                
        let items = Observable.just(array)
        
        items.bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
            
        
        ///点击事件
        tableView.rx.itemSelected.map { indexPath in
            return (indexPath, self.dataSource[indexPath.section].items[indexPath.row].title)
        }.subscribe(onNext: { pair in
            PrintLog.info("Tapped `\(pair.1)` @ \(pair.0)")
        }).disposed(by: disposeBag)
        
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        
    }
    
    func bindViewModel() {
        
        binding()
    }
    
}

extension RxTestController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}
