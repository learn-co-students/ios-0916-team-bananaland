//
//  CookButton.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/30/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

public class CookButtonStyleKit : NSObject {
    
    //// Drawing Methods
    
    public dynamic class func drawCookButton(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 130, height: 130), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 130, height: 130), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 130, y: resizedFrame.height / 130)
        
        
        //// Color Declarations
        let color = UIColor(red: 0.800, green: 0.320, blue: 0.320, alpha: 1.000)
        
        //// Group
        context.saveGState()
        context.setBlendMode(.multiply)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 39.5, y: 24.5, width: 58, height: 78))
        color.setFill()
        rectanglePath.fill()
        color.setStroke()
        rectanglePath.lineWidth = 4
        rectanglePath.lineJoinStyle = .bevel
        rectanglePath.stroke()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 45.8, y: 42.61))
        bezierPath.addCurve(to: CGPoint(x: 91.19, y: 42.61), controlPoint1: CGPoint(x: 92.75, y: 42.61), controlPoint2: CGPoint(x: 91.19, y: 42.61))
        UIColor.white.setStroke()
        bezierPath.lineWidth = 3
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 45.8, y: 63.5))
        bezier2Path.addCurve(to: CGPoint(x: 91.19, y: 63.5), controlPoint1: CGPoint(x: 92.75, y: 63.5), controlPoint2: CGPoint(x: 91.19, y: 63.5))
        UIColor.white.setStroke()
        bezier2Path.lineWidth = 3
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 45.8, y: 85.79))
        bezier3Path.addCurve(to: CGPoint(x: 91.19, y: 85.79), controlPoint1: CGPoint(x: 92.75, y: 85.79), controlPoint2: CGPoint(x: 91.19, y: 85.79))
        UIColor.white.setStroke()
        bezier3Path.lineWidth = 3
        bezier3Path.stroke()
        
        
        context.endTransparencyLayer()
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
