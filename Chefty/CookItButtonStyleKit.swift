//
//  CookItButtonStyleKit.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/1/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

public class CookItButtonStyleKit : NSObject {
    
    //// Drawing Methods
    
    public dynamic class func drawCookItButton(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 130, height: 130), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 130, height: 130), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 130, y: resizedFrame.height / 130)
        
        
        //// Color Declarations
        let color4 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.745)
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 24, y: 22, width: 84, height: 84))
        color4.setFill()
        ovalPath.fill()
        UIColor.black.setStroke()
        ovalPath.lineWidth = 3
        ovalPath.stroke()
        
        
        //// Group
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 82.81, y: 52.65))
        bezierPath.addCurve(to: CGPoint(x: 82.81, y: 58.61), controlPoint1: CGPoint(x: 82.81, y: 52.65), controlPoint2: CGPoint(x: 82.81, y: 55.05))
        bezierPath.addLine(to: CGPoint(x: 86, y: 58.61))
        bezierPath.addLine(to: CGPoint(x: 86, y: 60.99))
        bezierPath.addLine(to: CGPoint(x: 82.81, y: 60.99))
        bezierPath.addCurve(to: CGPoint(x: 82.81, y: 89), controlPoint1: CGPoint(x: 82.81, y: 71.73), controlPoint2: CGPoint(x: 82.81, y: 89))
        bezierPath.addLine(to: CGPoint(x: 48.73, y: 89))
        bezierPath.addCurve(to: CGPoint(x: 48.73, y: 60.99), controlPoint1: CGPoint(x: 48.73, y: 89), controlPoint2: CGPoint(x: 48.73, y: 71.73))
        bezierPath.addLine(to: CGPoint(x: 45, y: 60.99))
        bezierPath.addLine(to: CGPoint(x: 45, y: 58.61))
        bezierPath.addLine(to: CGPoint(x: 48.73, y: 58.61))
        bezierPath.addCurve(to: CGPoint(x: 48.73, y: 52.65), controlPoint1: CGPoint(x: 48.73, y: 55.05), controlPoint2: CGPoint(x: 48.73, y: 52.65))
        bezierPath.addLine(to: CGPoint(x: 82.81, y: 52.65))
        bezierPath.addLine(to: CGPoint(x: 82.81, y: 52.65))
        bezierPath.close()
        UIColor.white.setStroke()
        bezierPath.lineWidth = 2.5
        bezierPath.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 66.03, y: 31.5))
        bezier3Path.addLine(to: CGPoint(x: 64.44, y: 34.48))
        bezier3Path.addLine(to: CGPoint(x: 63.9, y: 36.27))
        bezier3Path.addLine(to: CGPoint(x: 64.97, y: 39.84))
        bezier3Path.addLine(to: CGPoint(x: 67.35, y: 42.13))
        bezier3Path.addLine(to: CGPoint(x: 67.1, y: 45.8))
        bezier3Path.addLine(to: CGPoint(x: 64.97, y: 48.78))
        UIColor.white.setStroke()
        bezier3Path.lineWidth = 2.5
        bezier3Path.lineCapStyle = .round
        bezier3Path.lineJoinStyle = .round
        bezier3Path.stroke()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: 75.62, y: 31.5))
        bezier4Path.addLine(to: CGPoint(x: 74.02, y: 34.48))
        bezier4Path.addLine(to: CGPoint(x: 73.49, y: 36.27))
        bezier4Path.addLine(to: CGPoint(x: 74.55, y: 39.84))
        bezier4Path.addLine(to: CGPoint(x: 76.94, y: 42.13))
        bezier4Path.addLine(to: CGPoint(x: 76.68, y: 45.8))
        bezier4Path.addLine(to: CGPoint(x: 74.55, y: 48.78))
        UIColor.white.setStroke()
        bezier4Path.lineWidth = 2.5
        bezier4Path.lineCapStyle = .round
        bezier4Path.lineJoinStyle = .round
        bezier4Path.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 55.92, y: 31.5))
        bezier2Path.addLine(to: CGPoint(x: 54.32, y: 34.48))
        bezier2Path.addLine(to: CGPoint(x: 53.79, y: 36.27))
        bezier2Path.addLine(to: CGPoint(x: 54.85, y: 39.84))
        bezier2Path.addLine(to: CGPoint(x: 57.23, y: 42.13))
        bezier2Path.addLine(to: CGPoint(x: 56.98, y: 45.8))
        bezier2Path.addLine(to: CGPoint(x: 54.85, y: 48.78))
        UIColor.white.setStroke()
        bezier2Path.lineWidth = 2.5
        bezier2Path.lineCapStyle = .round
        bezier2Path.lineJoinStyle = .round
        bezier2Path.stroke()
        
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
