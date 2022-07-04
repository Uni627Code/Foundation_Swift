//
//  OtherViewController.swift
//  UFoundation
//
//  Created by uni on 2021/4/19.
//

import UIKit
//import flutter_boost

class OtherViewController: UITableViewController {
    
    //添加自定义回调事件后获取的回调，用于在deinit中remove监听器
//    var removeListener:FBVoidCallback?
    
    var titleArray = [" 原生 跳转 Flutter", "FLutter 跳转 原生"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //这里注册事件监听，监听flutter发送到iOS的事件
        
//        self.removeListener =  FlutterBoost.instance().addEventListener({[weak self] key, dic in
//            //注意，如果这里self持有removeListener，而这个闭包中又有self的话，要用weak self
//            //否则就有self->removeListener->self 循环引用
//
//            //在这里处理你的事件
//
//        }, forName: "event")
        

    }
    
    

}


extension OtherViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else { return UITableViewCell() }
        
        cell.textLabel?.text = titleArray[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let router = PlatformRouter()
//        switch indexPath.row {
//        case 0:
//            router.open("mainPage", urlParams: ["params": "这是参数"], exts: ["animated": true]) { (bool) in
//                //将原生页面的数据回传到flutter侧的页面的的方法
//                FlutterBoost.instance()?.sendResultToFlutter(withPageName: "mainPage", arguments: ["event": "value111"])
//            }
//            
//        default:
//                FlutterBoost.instance()?.open("mainPage", arguments: ["animated": true], completion: { (bool) in
//        
//                })
//        }
    }
}
