
//  GAFlutterRooterViewController.swift
//  Community
//
//  Created by uni on 2020/9/20.
//  Copyright © 2020 EinYun. All rights reserved.


import Flutter
import FlutterPluginRegistrant
import flutter_boost
import fluttertoast
class GAFlutterRooterViewController: FBFlutterViewContainer {

    var channelMethodArguments: [String: Any] = ["navigate":["path":"ROCKET_GAME","data":["duration":30]]]

    // 要与main.dart中一致
    var channelName = "event"

    //单项管道，有可能使用多次
    private var eventSink:FlutterEventSink?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flutter-iOSTest-Demo"
        skipFlutter()
        fromFlutter()

        view.backgroundColor = .white
        
    }

    ///FlutterMethodChannel 主要是用于Flutter向iOS端发送参数
    func skipFlutter() {
        // 初始化交互通道FlutterMethodChannel
        let messageChannel = FlutterMethodChannel(name: channelName, binaryMessenger: self.binaryMessenger)
//        messageChannel.invokeMethod("navigate", arguments: ["token": "CurrentUser.token","data":["duration":30]])

        //Flutter 传参数的回调
        messageChannel.setMethodCallHandler {[weak self] (call, result) in
            guard let strongSelf = self else { return }
            // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
            // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
            // result 是给flutter的回调， 该回调只能使用一次
            print("flutter 给到我 method:\(call.method) arguments:\(String(describing: call.arguments))")
            guard call.method == "getBatteryLevel" else {
               result(FlutterMethodNotImplemented)
               return
            }
            strongSelf.receiveBatteryLevel(result: result)
        }
    
    }
    
    

    //iOS端向Flutter传值
    func fromFlutter() {
//         要与main.dart中一致(单项通信管道，原生向Flutter发送消息)
//        let messageEventChannel = FlutterEventChannel(name: channelName, binaryMessenger: self.binaryMessenger)
//        messageEventChannel.setStreamHandler(self)
    }
}

////遵守协议
extension GAFlutterRooterViewController: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events;
        if (self.eventSink != nil) {
            self.eventSink!(["token": "CurrentUser.token"])
        }
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil;
        return nil
    }
    
    
}


extension GAFlutterRooterViewController {

    private func receiveBatteryLevel(result: FlutterResult) {
      let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
      if device.batteryState == UIDevice.BatteryState.unknown {
        result(FlutterError(code: "UNAVAILABLE",
                            message: "Battery info unavailable",
                            details: nil))
      } else {
        result(Int(device.batteryLevel * 100))
      }
    }
}
