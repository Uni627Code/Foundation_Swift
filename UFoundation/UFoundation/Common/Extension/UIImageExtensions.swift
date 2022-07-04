//
//  UIImageExtensions.swift
//  EUI
//
//  Created by LynnCheng on 2019/9/27.
//  Copyright © 2019 LynnCheng. All rights reserved.
//

import UIKit

extension UIImage {

    /// 颜色生成图片
    /// - Parameters:
    ///   - color: 颜色
    ///   - size: 大小
    /// - Returns: UIImage
    public static func imageWithColor(_ color: UIColor, size:CGSize = CGSize(width: 1, height: 1)) -> UIImage
    {
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext? = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let imageReturn: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return imageReturn
    }

    /// 颜色生成渐变图片
    /// - Parameters:
    ///   - leftColor: 左边颜色
    ///   - rightColor: 右边颜色
    ///   - size: 大小
    /// - Returns: UIImage
    public class func gradient(leftColor:UIColor, rightColor:UIColor, size:CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        let gradientLayer = CAGradientLayer()
        let gradientColors = [leftColor.cgColor, rightColor.cgColor]
        
        //创建CAGradientLayer对象并设置参数
        gradientLayer.colors = gradientColors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil}
        gradientLayer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image
    }
    
    //TODO: ios13之前能用？
    var launchImage:UIImage? {
        let viewSize = UIScreen.main.bounds.size
        let viewOr = "Portrait"//垂直
        var launchImageName = ""
        let tmpLaunchImages = Bundle.main.infoDictionary!["UILaunchImages"] as? [Any]
        for dict in tmpLaunchImages! {
            if let someDict = dict as? [String: Any] {
                let imageSize = NSCoder.cgSize(for: someDict["UILaunchImageSize"] as! String)
                if __CGSizeEqualToSize(viewSize, imageSize) && viewOr == someDict["UILaunchImageOrientation"] as! String {
                    launchImageName = someDict["UILaunchImageName"] as! String
                }
            }
        }
        let launchImage = UIImage(named: launchImageName)
        return launchImage
    }
    
    func maskImage(maskImage:UIImage) -> UIImage {

        let frame = CGRect(x: 0, y: 0, width: self.size.width/2, height:self.size.height)

        // 开始给图片添加图片
        UIGraphicsBeginImageContext(self.size)
        self.draw(in: frame)
        maskImage.draw(in: frame, blendMode: .normal, alpha: 1)
        let waterMarkedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return waterMarkedImage
    }

}


//MARK - 二维码
extension UIImage {
    /// 生成二维码
    /// - Parameters:
    ///   - text: 二维码内容
    ///   - iconimg: 二维码中间的icon 为nil即不显示
    public static func createQRCodeImage(_ text:String, iconName:String? = nil, size:CGSize) ->UIImage{
        // 创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        filter?.setValue(text.data(using: .utf8,allowLossyConversion: true), forKey: "inputMessage")
        
        // 取出生成的二维码（不清楚）
        if let outputImage = filter?.outputImage {
            let qrCodeImage = setupHighDefinitionUIImage(outputImage, size: size)
            if iconName != nil  {
                let icon = circleImageWithImage(iconName ?? "", borderWidth: 50, borderColor: .white)
                let newImage = syntheticImage(qrCodeImage, iconImage: icon, width: 70, height: 70)
                return newImage
            }
            return qrCodeImage
        }
        return UIImage()
    }
    
    
    /// 生成高清的UIImage
    /// - Parameters:
    ///   - image: 二维码
    ///   - size: 大小
    private static func setupHighDefinitionUIImage(_ image:CIImage, size:CGSize) ->UIImage{
        let integral = image.extent.integral
        
        let proportion = min(size.width/integral.width, size.height/integral.height)
        let width = integral.width * proportion
        let height = integral.height * proportion
        
        let colorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage = context.createCGImage(image, from: integral)!
        
        bitmapRef.interpolationQuality = .none
        bitmapRef.scaleBy(x: proportion, y: proportion)
        bitmapRef.draw(bitmapImage, in: integral)
        
        let image = bitmapRef.makeImage()!
        
        return UIImage(cgImage: image)
        
    }
    
    /// 生成边框
    /// - Parameters:
    ///   - sourceImage: icon图片
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框颜色
    private static func circleImageWithImage(_ iconName: String, borderWidth: CGFloat, borderColor: UIColor) -> UIImage {
        
        let sourceImage:UIImage = UIImage(named: iconName) ?? UIImage()
        let imageWidth = sourceImage.size.width + 2 * borderWidth
        let imageHeight = sourceImage.size.height + 2 * borderWidth
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: imageWidth, height: imageHeight), false, 0.0)
        UIGraphicsGetCurrentContext()
        
        let radius = (sourceImage.size.width < sourceImage.size.height ? sourceImage.size.width:sourceImage.size.height) * 0.5
        let bezierPath = UIBezierPath(arcCenter: CGPoint(x: imageWidth * 0.5, y: imageHeight * 0.5), radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        bezierPath.lineWidth = borderWidth
        borderColor.setStroke()
        bezierPath.stroke()
        bezierPath.addClip()
        sourceImage.draw(in: CGRect(x: borderWidth, y: borderWidth, width: sourceImage.size.width, height: sourceImage.size.height))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    //image: 二维码 iconImage:头像图片 width: 头像的宽 height: 头像的宽
    private static func syntheticImage(_ image: UIImage, iconImage:UIImage, width: CGFloat, height: CGFloat) -> UIImage{
        //开启图片上下文
        UIGraphicsBeginImageContext(image.size)
        //绘制背景图片
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let x = (image.size.width - width) * 0.5
        let y = (image.size.height - height) * 0.5
        iconImage.draw(in: CGRect(x: x, y: y, width: width, height: height))
        //取出绘制好的图片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        //返回合成好的图片
        if let newImage = newImage {
            return newImage
        }
        return UIImage()
    }
    
}

extension UIImage {
    /// 图片加水印
    ///
    /// - Parameters:
    ///   - text: 水印完整文字
    ///   - textColor: 文字颜色
    ///   - textFont: 文字大小
    ///   - suffixText: 尾缀文字(如果是nil可以不传)
    ///   - suffixFont: 尾缀文字大小(如果是nil可以不传)
    ///   - suffixColor: 尾缀文字颜色(如果是nil可以不传)
    /// - Returns: 水印图片
    func drawTextInImage(text: String, textColor: UIColor, textFont: UIFont,suffixText: String?, suffixFont: UIFont?, suffixColor: UIColor?) -> UIImage {
        // 开启和原图一样大小的上下文（保证图片不模糊的方法）
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)

        // 图形重绘
        self.draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))

        var suffixAttr: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:textColor, NSAttributedString.Key.font:textFont]
        let attrS = NSMutableAttributedString(string: text, attributes: suffixAttr)

        // 添加后缀的属性字符串
        if let suffixStr = suffixText {
            let range = NSRange(location: text.count - suffixStr.count, length: suffixStr.count)
            if suffixFont != nil {
                suffixAttr[NSAttributedString.Key.font] = suffixFont
            }

            if suffixColor != nil {
                suffixAttr[NSAttributedString.Key.foregroundColor] = suffixColor
            }
            attrS.addAttributes(suffixAttr, range: range)
        }

        // 文字属性
        let size =  attrS.size()
        let x = (self.size.width - size.width) / 2
        let y = (self.size.height - size.height) / 2

        // 绘制文字
        attrS.draw(in: CGRect(x: x, y: y, width: size.width, height: size.height))
        // 从当前上下文获取图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        return image!
    }
    
    
    ///水印位置枚举
    public enum WaterMarkCorner{
        case TopLeft
        case TopRight
        case BottomLeft
        case BottomRight
    }

    //添加水印方法
    public func waterMarkedImage(waterMarkText:String, corner:WaterMarkCorner = .BottomRight,
                                 margin:CGPoint = CGPoint(x: 20, y: 20), waterMarkTextColor:UIColor = .white,
                                 waterMarkTextFont:UIFont = Fonts.middleTitle,
                                 backgroundColor:UIColor = .clear) -> UIImage {

        let textAttributes = [NSAttributedString.Key.foregroundColor:waterMarkTextColor,
                              NSAttributedString.Key.font:waterMarkTextFont]
        let textSize = NSString(string: waterMarkText).size(withAttributes: textAttributes)
        var textFrame = CGRect(x: 0, y: 0, width: textSize.width, height: textSize.height)

        let imageSize = self.size
        switch corner{
        case .TopLeft:
            textFrame.origin = margin
        case .TopRight:
            textFrame.origin = CGPoint(x: imageSize.width - textSize.width - margin.x, y: margin.y)
        case .BottomLeft:
            textFrame.origin = CGPoint(x: margin.x, y: imageSize.height - textSize.height - margin.y)
        case .BottomRight:
            textFrame.origin = CGPoint(x: imageSize.width - textSize.width - margin.x,
                                       y: imageSize.height - textSize.height - margin.y)
        }

        // 开始给图片添加文字水印
        UIGraphicsBeginImageContext(imageSize)
        self.draw(in: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
        NSString(string: waterMarkText).draw(in: textFrame, withAttributes: textAttributes)

        guard let waterMarkedImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()

        return waterMarkedImage
    }
    
    /**
     *  重设图片大小
     */
    public func reSizeImage(reSize:CGSize) -> UIImage {
        //UIGraphicsBeginImageContext(reSize);
        UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        guard let reSizeImage = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        UIGraphicsEndImageContext();
        return reSizeImage;
    }

    /**
     *  等比率缩放
     */
    public func scaleImage(scaleSize:CGFloat)->UIImage {
        let reSize = CGSize(width: self.size.width * scaleSize, height: self.size.height * scaleSize)
        return reSizeImage(reSize: reSize)
    }
}
