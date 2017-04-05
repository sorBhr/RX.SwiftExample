//
//  UIExtension.swift
//  RX.SwiftExample
//
//  Created by 白海瑞 on 2017/4/1.
//  Copyright © 2017年 rx.swift. All rights reserved.
//

import Foundation
import UIKit
public extension UIView{
    
    /// layer corner
    ///
    /// - parameter rect:       范围:默认为view.bounds
    /// - parameter rectCorner: UIRectCorner:默认为allCorners
    /// - parameter size:       圆角size:默认为(6,6)
    public func layerCorner(rect:CGRect = CGRect.zero,rectCorner:UIRectCorner = [.allCorners] ,size:CGSize = CGSize(width: 6, height: 6)) -> Void {
        let rectFrame = rect != CGRect.zero ? rect : self.bounds
        print("rectFrame = \(rectFrame)")
        let maskLayer = CAShapeLayer()
        let path = UIBezierPath.init(roundedRect: rectFrame, byRoundingCorners: rectCorner, cornerRadii: size)
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}
