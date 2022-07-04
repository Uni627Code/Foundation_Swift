//
//  CLBlueToothProtocol.swift
//  UFoundation
//
//  Created by 陆小懒 on 2022/3/14.
//  Copyright © 2022 Uni. All rights reserved.
//

import Foundation
import CoreBluetooth


protocol CLBlueToothProtocol {
    
    
    /// 创建 中心设备管理器
    /// - Returns: description
    func createCentralManager()
    
    
    
    /// 写入数据
    func writeData(_ data: Data)
    
}
