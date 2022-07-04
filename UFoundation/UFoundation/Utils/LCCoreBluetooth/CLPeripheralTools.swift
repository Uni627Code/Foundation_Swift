//
//  CLPeripheralTools.swift
//  UFoundation
//
//  Created by 陆小懒 on 2022/3/14.
//  Copyright © 2022 Uni. All rights reserved.
//

import Foundation
import CoreBluetooth
//import CoreBluetooth

class CLPeripheralTools: NSObject {
    
    var manager = CBPeripheralManager()
    
    
    func createPeripheral() -> CBPeripheralManager {
        
        manager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
        
        ///开始发送广播
        var params: [String: Any] = [:]
        
        params[CBAdvertisementDataLocalNameKey] = "对应设置NSString类型的广播名"
        
        params[CBAdvertisementDataManufacturerDataKey] = "外设制造商的NSData数据"
        
        params[CBAdvertisementDataServiceDataKey] = "外设制造商的CBUUID数据"
        
        params[CBAdvertisementDataServiceUUIDsKey] = "服务的UUID与其对应的服务数据字典数组"
        
        params[CBAdvertisementDataOverflowServiceUUIDsKey] = "附加服务的UUID数组"
        
        params[CBAdvertisementDataTxPowerLevelKey] = "外设的发送功率 NSNumber类型"
        
        params[CBAdvertisementDataIsConnectable] = "外设是否可以连接"
        
        params[CBAdvertisementDataSolicitedServiceUUIDsKey] = "服务的UUID数组"
        
        manager.startAdvertising(params)
        
        ///设置一个连接的具体central设备的延时 枚举如下
//        manager.setDesiredConnectionLatency(.high, for: <#T##CBCentral#>)
        
        return manager
        
        
    }
    
    
    
}

extension CLPeripheralTools: CBPeripheralManagerDelegate {
    
    /// 这个方法是必须实现的 状态可用后可以发送广播
    /// - Parameter peripheral: peripheral description
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
    }
    
    /// 连接回复时调用的方法 和centralManager类似
    /// - Parameters:
    ///   - peripheral: peripheral description
    ///   - dict: dict description
    func peripheralManager(_ peripheral: CBPeripheralManager, willRestoreState dict: [String : Any]) {
        
    }
    
    /// 开始发送广播时调用的方法
    /// - Parameters:
    ///   - peripheral: peripheral description
    ///   - error: error description
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        
        
    }
    
    /// //添加服务调用的回调
    /// - Parameters:
    ///   - peripheral: peripheral description
    ///   - service: service description
    ///   - error: error description
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        
    }
    
    
    /// 当一个central设备订阅一个特征值时调用的方法
    /// - Parameters:
    ///   - peripheral: peripheral description
    ///   - central: central description
    ///   - characteristic: characteristic description
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        
    }
    
    /// 取消订阅一个特征值时调用的方法
    /// - Parameters:
    ///   - peripheral: peripheral description
    ///   - central: central description
    ///   - characteristic: characteristic description
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        
    }
    
    /// 收到读请求时触发的方法
    /// - Parameters:
    ///   - peripheral: peripheral description
    ///   - request: request description
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest) {
        
    }
    
    /// 收到写请求时触发的方法
    /// - Parameters:
    ///   - peripheral: peripheral description
    ///   - requests: requests description
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        
    }
    
    /// 外设准备更新特征值时调用的方法
    /// - Parameter peripheral: peripheral description
    func peripheralManagerIsReady(toUpdateSubscribers peripheral: CBPeripheralManager) {
        
    }

    
}

//extension CLPeripheralTools: CBPeripheralDelegate {
//
//}
