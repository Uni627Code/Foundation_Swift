//
//  CLCoreBluetooth.swift
//  UFoundation
//
//  Created by 陆小懒 on 2022/3/14.
//  Copyright © 2022 Uni. All rights reserved.
//

import UIKit
import CoreBluetooth
import KeychainAccess
class CLCoreBluetooth: NSObject, CLBlueToothProtocol, CBCentralManagerDelegate  {
    
    var manager: CBCentralManager?
    
    var currentPeripheral: CBPeripheral?
    
    var writeCharacteristic: CBCharacteristic?
    
    
    /// 第一步：创建manager
    /// - Returns: description
    func createCentralManager() {
        
        var options: [String: Any] = [:]
        options[CBCentralManagerOptionShowPowerAlertKey] = true
//        options[CBCentralManagerOptionRestoreIdentifierKey] = "533CD5EF-4D83-55FA-F68B-FCB3CEC93698"
        manager = CBCentralManager(delegate: self, queue: nil, options: options)
        
        let queue = DispatchQueue(label: "子线程")
        
        manager = CBCentralManager(delegate: self, queue: queue, options: options)
        
    }
    
    func writeData(_ data: Data) {
        
        if let currentPeripheral = self.currentPeripheral, let writeCharacteristic = self.writeCharacteristic {
            currentPeripheral.writeValue(data, for: writeCharacteristic, type: CBCharacteristicWriteType.withResponse)
        }
    }
    
}


extension CLCoreBluetooth {
    
    //第二步
    /// 在初始化管理中心完成后，会回调代理中的如下方法
    /// 这个方法中可以获取到管理中心的状态
    /// - Parameter central: central description
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        
        //serviceUUIDs用于扫描一个特点ID的外设 options用于设置一些扫描属性 键值如下
        /*
         //是否允许重复扫描 对应NSNumber的bool值，默认为NO，会自动去重
         NSString *const CBCentralManagerScanOptionAllowDuplicatesKey;
         //要扫描的设备UUID 数组 对应NSArray
         NSString *const CBCentralManagerScanOptionSolicitedServiceUUIDsKey;
         */
        
        //蓝牙可用，开启扫描
        switch central.state {
        case .poweredOn:
            var options: [String: Any] = [:]
            options[CBCentralManagerScanOptionAllowDuplicatesKey] = false
            //        options[CBCentralManagerScanOptionSolicitedServiceUUIDsKey] = [CBUUID(s)]
                        
            var services: [CBUUID] = []
            services.append(CBUUID(string: "533CD5EF-4D83-55FA-F68B-FCB3CEC93698"))
            
            central.scanForPeripherals(withServices: nil, options: options)
        default:
            PrintLog.error("蓝牙不可用")
        }
        
        
        
    }
    
    /// 第三步： 扫描的结果会在如下代理方法中回掉
    /// - Parameters:
    ///   - central: 当前中心设备
    ///   - peripheral: 扫描到的外设
    ///   - advertisementData: 是外设发送的广播数据
    ///   - RSSI: 是信号强度
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        
        //扫描到外设后，通过下面方法可以连接一个外设
        if let name = peripheral.name {
            if name.contains("陆小懒的MacBook Pro") {
                central.stopScan()
                self.currentPeripheral = peripheral
                central.connect(peripheral, options: nil)
                PrintLog.info(peripheral.identifier)
            }
        }
        
        //        //取消一个外设的连接
        ////        central.cancelPeripheralConnection(peripheral)
        //        PrintLog.info(advertisementData.description)
        
    }
    
    
    /// 连接外设成功
    /// - Parameters:
    ///   - central: central description
    ///   - peripheral: peripheral description
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        
        //设置代理发现服务
        peripheral.delegate = self
        
        peripheral.discoverServices(nil)
    }
    
    /// 连接外设失败
    /// - Parameters:
    ///   - central: central description
    ///   - peripheral: peripheral description
    ///   - error: error description
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        
    }
    
    /// 断开外设连接
    /// - Parameters:
    ///   - central: central description
    ///   - peripheral: peripheral description
    ///   - error: error description
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        
    }
    
    /// 当管理中心恢复时会调用如下代理
    /// - Parameters:
    ///   - central: central description
    ///   - dict: dict description
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        
    }
    
}

extension CLCoreBluetooth: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        
        if error == nil {
            
            if let services = peripheral.services {
                for aService in services {
                    //发现特征
                    peripheral.discoverCharacteristics(nil, for: aService)
                }
            } else {
                //                如果有错，则主动断开，然后会走
                self.manager?.cancelPeripheralConnection(peripheral)
            }
            
        }
    }
    
    
    /// 发现Characteristics成功
    /// - Parameters:
    ///   - peripheral: peripheral description
    ///   - service: service description
    ///   - error: error description
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        
        
        if error == nil {
            
            guard let characteristics = service.characteristics else { return  }
            
            for achar in characteristics {
                
                //判断Characteristic属性类型
                
                if achar.properties == CBCharacteristicProperties.read {
                    peripheral.readValue(for: achar)
                } else {
                    //                    if achar.properties == CBCharacteristicProperties.write {
                    self.writeCharacteristic = achar
                    peripheral.setNotifyValue(true, for: achar)
                    //}
                }
            }
        } else {
            //            如果有错，则主动断开，然后会走
            self.manager?.cancelPeripheralConnection(peripheral)
        }
    }
    
    /// 判断使能是否写成功
    /// - Parameters:
    ///   - peripheral: peripheral description
    ///   - characteristic: characteristic description
    ///   - error: error description
    func peripheral(_ peripheral: CBPeripheral, didUpdateNotificationStateFor characteristic: CBCharacteristic, error: Error?) {
        
        if characteristic.isNotifying == true {
            NSLog("使能是否写成功 = 能");
        }
    }
    
    
}

extension CLCoreBluetooth {
    
    
    /// 写入成功
    /// - Parameters:
    ///   - peripheral: peripheral description
    ///   - characteristic: characteristic description
    ///   - error: error description
    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        PrintLog.info("写入成功")
    }
    
    /// 从Peripheral读取数据
    /// - Parameters:
    ///   - peripheral: peripheral description
    ///   - characteristic: characteristic description
    ///   - error: error description
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let responseData = characteristic.value {
            let receive: String = String(data: responseData, encoding: .utf8)!
            
            PrintLog.info("从Peripheral读取数据--\(receive)");
        }
    }
}

