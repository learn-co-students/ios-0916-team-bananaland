//
//  ClockIcon.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/5/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

public class ClockIcon : NSObject {
    
    //// Drawing Methods
    
    public dynamic class func drawClockIcon(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 120, height: 120), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 120, height: 120), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 120, y: resizedFrame.height / 120)
        
        
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 32, y: 28, width: 61, height: 61))
        UIColor.white.setStroke()
        ovalPath.lineWidth = 2
        ovalPath.stroke()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 62.5, y: 33.5))
        bezierPath.addCurve(to: CGPoint(x: 62.5, y: 39.5), controlPoint1: CGPoint(x: 62.5, y: 39.5), controlPoint2: CGPoint(x: 62.5, y: 39.5))
        UIColor.white.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        context.saveGState()
        context.translateBy(x: 36.5, y: 58.5)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 0, y: 0))
        bezier2Path.addCurve(to: CGPoint(x: 0, y: 6), controlPoint1: CGPoint(x: 0, y: 6), controlPoint2: CGPoint(x: 0, y: 6))
        UIColor.white.setStroke()
        bezier2Path.lineWidth = 2
        bezier2Path.stroke()
        
        context.restoreGState()
        
        
        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: 62.5, y: 77.5))
        bezier4Path.addCurve(to: CGPoint(x: 62.5, y: 83.5), controlPoint1: CGPoint(x: 62.5, y: 83.5), controlPoint2: CGPoint(x: 62.5, y: 83.5))
        UIColor.white.setStroke()
        bezier4Path.lineWidth = 2
        bezier4Path.stroke()
        
        
        //// Bezier 3 Drawing
        context.saveGState()
        context.translateBy(x: 81.5, y: 58.5)
        context.rotate(by: -90 * CGFloat.pi/180)
        
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 0, y: 0))
        bezier3Path.addCurve(to: CGPoint(x: 0, y: 6), controlPoint1: CGPoint(x: 0, y: 6), controlPoint2: CGPoint(x: 0, y: 6))
        UIColor.white.setStroke()
        bezier3Path.lineWidth = 2
        bezier3Path.stroke()
        
        context.restoreGState()
        
        
        //// Bezier 5 Drawing
        let bezier5Path = UIBezierPath()
        bezier5Path.move(to: CGPoint(x: 63, y: 58))
        bezier5Path.addCurve(to: CGPoint(x: 75, y: 46), controlPoint1: CGPoint(x: 74.6, y: 46.4), controlPoint2: CGPoint(x: 75, y: 46))
        UIColor.white.setStroke()
        bezier5Path.lineWidth = 2
        bezier5Path.lineCapStyle = .round
        bezier5Path.stroke()
        
        
        //// Bezier 6 Drawing
        let bezier6Path = UIBezierPath()
        bezier6Path.move(to: CGPoint(x: 63, y: 58))
        bezier6Path.addLine(to: CGPoint(x: 63, y: 68))
        UIColor.white.setStroke()
        bezier6Path.lineWidth = 2
        bezier6Path.lineCapStyle = .round
        bezier6Path.lineJoinStyle = .round
        bezier6Path.stroke()
        
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
