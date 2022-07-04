//
//  AppConstants.swift
//  UFoundation
//
//  Created by 陆小懒 on 2022/3/30.
//  Copyright © 2022 Uni. All rights reserved.
//

import UIKit




func getJSONStringFromArray(array:[String]) ->String{
    
    if !JSONSerialization.isValidJSONObject(array){
        return ""
    }
    
    guard let data = try? JSONSerialization.data(withJSONObject: array, options: []) else {
        return ""
    }
    
    guard let jsonString = String(data: data, encoding: .utf8) else {
        return ""
    }
    return jsonString
}

///转字符串数组
func getArrayFromJSONString(jsonString:String) -> [String]{
    guard let jsonData = jsonString.data(using: .utf8) else {
        return []
    }
    
    guard let array = try?JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String] else {
        return []
    }
    return array
}

///转json字符串
func getJSONStringFromDictionary(dictionary:NSDictionary) -> String {
    if !JSONSerialization.isValidJSONObject(dictionary) {
        return ""
    }
    guard let data = try? JSONSerialization.data(withJSONObject: dictionary, options: []) else {
        return ""
    }
    guard let JSONString = String(data: data, encoding: .utf8) else {
        return ""
    }
    return JSONString
}

///转字典
func getDictionaryFromJSONString(jsonString:String) -> [String:Any]{
    guard let jsonData = jsonString.data(using: .utf8) else {
        return [:]
    }
    
    guard let dict = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String:Any] else {
        return [:]
    }
    
    return dict
}

/// 时间戳转时间
/// - Parameter timeStamp: 时间戳
 func timeStampToString(timeStamp:Int, outputFormatter: String? = "yyyy-MM-dd HH:mm:ss") -> String{
    
    let timeString = String(timeStamp)
    let timeSta:TimeInterval
    if timeString.count == 10 {
        timeSta = TimeInterval(timeStamp)
    }
    else{
        timeSta = TimeInterval(timeStamp / 1000)
    }
    let date = NSDate(timeIntervalSince1970: timeSta)
    let dfmateer = DateFormatter()
    dfmateer.dateFormat = outputFormatter
    return dfmateer.string(from: date as Date)
}

/// 时间戳转时间
/// - Parameter timeStamp: 时间戳
 func timeStampString(timeString: String, outputFormatter: String) -> String{
    
    let interval: TimeInterval = TimeInterval.init(Double(timeString) ?? 0)
    let date = Date(timeIntervalSince1970: interval)
    let dfmateer = DateFormatter()
    //自定义日期格式
    dfmateer.dateFormat = outputFormatter
    return dfmateer.string(from: date as Date)

}


/// 时间转时间戳函数
/// - Parameters:
///   - time: 时间
///   - inputFormatter: DateFormatter
func timeToTimeStamp(time: String, inputFormatter:String) -> Double {
    let dfmatter = DateFormatter()
    //设定时间格式,这里可以设置成自己需要的格式
    dfmatter.dateFormat = inputFormatter
    let date = dfmatter.date(from: time)
    let timeStamp = date?.timeIntervalSince1970
       
    return timeStamp ?? 0
}

/// 获取当前时间戳
func timeStamp() -> Int {
    let now = NSDate()
    let timeInterval: TimeInterval = now.timeIntervalSince1970
    let timeStamp = Int(timeInterval)
    return timeStamp
}

func compareDate(startDate:String,endDate:String) -> Int {
    
    var comparisonResult:Int = 0
    let formatter = DateFormatter.init()
    formatter.dateFormat = "yyyy-MM-dd"
    var date1 = Date()
    var date2 = Date()
    date1 = formatter.date(from: startDate) ?? Date()
    date2 = formatter.date(from: endDate) ?? Date()
    let result = date1.compare(date2)
    switch result {
    case .orderedAscending:
        comparisonResult = -1
    case .orderedDescending:
        comparisonResult = 1
    case .orderedSame:
        comparisonResult = 0
    default:
        return comparisonResult
    }
    return comparisonResult
}

func dateConvertString(date:Date, dateFormat:String="yyyy-MM-dd") -> String {
        let timeZone = TimeZone.init(identifier: "UTC")
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date.components(separatedBy: " ").first!
}

func getNewDate() -> Date {
    let gregorian = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
     var components = gregorian?.components(NSCalendar.Unit(rawValue: NSCalendar.Unit.weekday.rawValue | NSCalendar.Unit.year.rawValue | NSCalendar.Unit.month.rawValue | NSCalendar.Unit.day.rawValue) , from: Date())
    if (components?.day) != nil {
         components?.day! += 1
     }
    
    if let component = components {
        let newDate = gregorian?.date(from: component)
        if let new = newDate {
            return new
        }
    }
    return Date()
}



func createMoreAttribute(leftText:String, leftFont:UIFont, leftColor:UIColor, rightText:String, rightFont:UIFont, rightColor:UIColor) -> NSMutableAttributedString {
    let attribute = NSMutableAttributedString(string: "\(leftText)\(rightText)")
    let leftAttribute = [NSAttributedString.Key.foregroundColor:leftColor,NSAttributedString.Key.font:leftFont]
    let rightAttribute = [NSAttributedString.Key.foregroundColor:rightColor,NSAttributedString.Key.font:rightFont]
    attribute.addAttributes(leftAttribute, range: NSRange(location: 0, length: leftText.count))
    attribute.addAttributes(rightAttribute, range: NSRange(location: leftText.count, length: rightText.count))
    return attribute
}


func GainAttribute(text:String,font:UIFont,color:UIColor) -> NSMutableAttributedString {
    let attribute = NSMutableAttributedString(string: "\(text)")
    
    let a = [NSAttributedString.Key.foregroundColor:color,NSAttributedString.Key.font:font]

    attribute.addAttributes(a, range: NSRange(location: 0, length: text.count))

    return attribute
}

// MARK:- 布局适配
func kScaleSize(_ size: Int) -> CGFloat {
    let scale = screenWidth / 375
    return CGFloat(scale) * CGFloat(size)
}


func handleTime(startTime: String, endTime: String) -> String{
    
    var sureStartTime = startTime
    if sureStartTime == "" {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"// 自定义时间格式
        sureStartTime = dateformatter.string(from: Date())
    }
    
    var sureEndTime = endTime
    if sureEndTime == "" {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"// 自定义时间格式
        sureEndTime = dateformatter.string(from: Date())
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    guard let date1 = dateFormatter.date(from: sureStartTime),
        let date2 = dateFormatter.date(from: sureEndTime) else {
        return ""
    }
    
    let components = NSCalendar.current.dateComponents([.month,.day,.hour,.minute,.year,.second], from: date1, to: date2)
    var time = String()
    let year = String((components.year ?? 0))
    let month = String((components.month ?? 0))
    let day = String((components.day ?? 0))
    let hour = String((components.hour ?? 0))
    let minute = String((components.minute ?? 0))
    let second = String((components.second ?? 0))

    if year != "0" {
        time = "\(year)年\(month)月\(day)天\(hour)时\(minute)分\(second)秒"
    }else if month != "0" {
        time = "\(month)月\(day)天\(hour)时\(minute)分\(second)秒"
    } else {
        time = "\(day)天\(hour)时\(minute)分\(second)秒"
    }
    return time
}

//文本 宽度固定,计算高度
func rowHeightWith(text: String, font: UIFont, width: CGFloat) -> CFloat{
    //小数向上取整
    let normalText : NSString = text as NSString
    let size = CGSize(width: width, height:CGFloat(MAXFLOAT))
    let dic = NSDictionary(object: font, forKey : kCTFontAttributeName as! NSCopying)
    let stringSize = normalText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [NSAttributedString.Key:Any], context:nil).size
    
    return  ceilf(CFloat(stringSize.height))
}

////获取拼音首字母（大写字母）
//func findFirstLetterFromString(_ aString: String) -> String {
//    //转变成可变字符串
//    let mutableString = NSMutableString.init(string: aString)
//
//    //将中文转换成带声调的拼音
//    CFStringTransform(mutableString as CFMutableString, nil,      kCFStringTransformToLatin, false)
//
//    //去掉声调
//    let pinyinString = mutableString.folding(options:          String.CompareOptions.diacriticInsensitive, locale:   NSLocale.current)
//
//    //将拼音首字母换成大写
//    let strPinYin = polyphoneStringHandle(nameString: aString,    pinyinString: pinyinString).uppercased()
//
//    
//    //截取大写首字母
////    let firstString = strPinYin.substring(to: strPinYin.index(strPinYin.startIndex, offsetBy: 1))
//    
//    var firstString = "#"
//    if strPinYin.count > 0 {
//        firstString = strPinYin.subStringTo(index: 0)
//    }
//    //判断首字母是否为大写
//    let regexA = "^[A-Z]$"
//    let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
//    return predA.evaluate(with: firstString) ? firstString : "#"
//}

//多音字处理，根据需要添自行加
func polyphoneStringHandle(nameString: String, pinyinString: String) -> String {
    if nameString.hasPrefix("长") {return "chang"}
    if nameString.hasPrefix("沈") {return "shen"}
    if nameString.hasPrefix("厦") {return "xia"}
    if nameString.hasPrefix("地") {return "di"}
    if nameString.hasPrefix("重") {return "chong"}
    return pinyinString
}


//数组转json
func getJSONStringFromArray(array:NSArray) -> String {
    
    if (!JSONSerialization.isValidJSONObject(array)) {
        print("无法解析出JSONString")
        return ""
    }
    
    let data : NSData! = try? JSONSerialization.data(withJSONObject: array, options: []) as NSData?
    let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
    return JSONString! as String
}

///给手机号中间四位加*
func hidePhoneNumber(number: String) -> String {
    if number.count < 5 {
        var str = ""
        for _ in 0 ..< number.count {
            str += "*"
        }
        return str
    } else {
        //替换一段内容，两个参数：替换的范围和用来替换的内容
        let start = number.index(number.startIndex, offsetBy: (number.count - 5) / 2)
        let end = number.index(number.startIndex, offsetBy: (number.count - 5) / 2 + 4)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return number.replacingCharacters(in: range, with: "****")
    }
}

