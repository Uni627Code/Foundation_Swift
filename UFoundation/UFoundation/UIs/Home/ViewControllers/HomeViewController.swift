//
//  HomeViewController.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit
import CoreBluetooth
import AsyncDisplayKit

class HomeViewController: BaseViewController, BindableType {
        
    var viewModel: HomeViewModel!
    
    var bluetooth = CLCoreBluetooth()
    
    lazy var dataArray: [Category] = {
        return DummyGenerator.sharedGenerator.randomCategories()
    }()
    
    
    lazy var tableNode: ASTableNode = {
        let table = ASTableNode.init(style: .grouped)
        table.frame = CGRect(x: 0, y: navigationHeight, width: screenWidth, height: screenHeight - navigationHeight)
        if #available(iOS 15.0, *) {
            table.view.sectionHeaderTopPadding = 0
        }
        
        table.delegate = self
        table.dataSource = self
        
        table.view.sectionHeaderHeight = 0
        table.view.sectionFooterHeight = 10
        table.view.separatorStyle = .none
        table.view.showsVerticalScrollIndicator = false
        table.backgroundColor = .white
        table.automaticallyAdjustsContentOffset = true
        
        table.view.contentSize = CGSize(width: screenWidth, height: screenHeight)
//        table.contentInset = UIEdgeInsets(top: -navigationHeight, left: 0, bottom: 0, right: 0)
        
        table.view.estimatedRowHeight = 100
        table.view.rowHeight = UITableView.automaticDimension
        
        return table
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "首页"
        
        viewModel = HomeViewModel()
        
        view.addSubnode(tableNode)
        

//        let button = UIButton(type: .custom)
//        button.setTitle("跳转", for: .normal)
//        button.setTitleColor(Color.beautifyGreen, for: .normal)
//        button.addTarget(self, action: #selector(skip), for: .touchUpInside)
//        view.addSubview(button)
//
//        button.snp.makeConstraints { (make) in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview()
//        }
        
//            bluetooth.createCentralManager()
        
//        var options: [String: Any] = [:]
//        options[CBCentralManagerOptionShowPowerAlertKey] = true
//        options[CBCentralManagerOptionRestoreIdentifierKey] = "533CD5EF-4D83-55FA-F68B-FCB3CEC93698"
//        manager = CBCentralManager(delegate: self, queue: nil, options: options)
        
    }
    
    @objc func skip() {
        
        let send: String  = "hello"

        let data: Data = send.data(using: .utf8)!
        
        bluetooth.writeData(data)
    }
    
    

    func bindViewModel() {
        
    }
    

}

extension HomeViewController: ASTableDelegate, ASTableDataSource {
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let model = dataArray[indexPath.row]
        let cell = {() -> ASCellNode in
            let node = HomeNodeCell(model)
            return node
        }
        return cell
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
        let products = self.dataArray[indexPath.row].products

//        var params = RouterParam()
//        params["id"] = products.id
//        params["name"] = "name"
//        Router.sharedInstance.open("OneViewController", params: params)
        
        if indexPath.row == 0 {
            var vc = RxTestController()
            let vm = RxTestViewModel()
            vm.dataArray = products
            vc.bind(to: vm)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = OneViewController()
            vc.dataArray = products
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
}

