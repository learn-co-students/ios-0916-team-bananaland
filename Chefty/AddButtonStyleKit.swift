//
//  AddButtonStyleKit.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/1/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation
import UIKit

public class AddButtonStyleKit : NSObject {
    
    //// Drawing Methods
    
    public dynamic class func drawaddButton(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 130, height: 130), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 130, height: 130), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 130, y: resizedFrame.height / 130)
        
        
        //// Color Declarations
        let color4 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.745)
        
        //// Group
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 25.5, y: 20.5, width: 84, height: 84))
        color4.setFill()
        ovalPath.fill()
        UIColor.black.setStroke()
        ovalPath.lineWidth = 3
        ovalPath.stroke()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 48.5, y: 62.5))
        bezierPath.addCurve(to: CGPoint(x: 85.5, y: 62.5), controlPoint1: CGPoint(x: 85.51, y: 62.5), controlPoint2: CGPoint(x: 85.5, y: 62.5))
        UIColor.white.setStroke()
        bezierPath.lineWidth = 3
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        context.saveGState()
        context.translateBy(x: 67.5, y: 81.5)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 0, y: 0))
        bezier2Path.addCurve(to: CGPoint(x: 37, y: 0), controlPoint1: CGPoint(x: 37.01, y: 0), controlPoint2: CGPoint(x: 37, y: 0))
        UIColor.white.setStroke()
        bezier2Path.lineWidth = 3
        bezier2Path.stroke()
        
        context.restoreGState()
        
        context.restoreGState()
        
    }
    
    
    
    
    @objc public enum ResizingBehavior: Int {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        
        public func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .aspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .aspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .stretch:
                break
            case .center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
