//
//  PersonIcon.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/5/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

public class PersonIcon : NSObject {
    
    //// Drawing Methods
    
    public dynamic class func drawPersonIcon(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 120, height: 120), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 120, height: 120), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 120, y: resizedFrame.height / 120)
        
        
        //// Group 2
        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 50.5, y: 42.5, width: 18.5, height: 18.5))
        UIColor.white.setFill()
        ovalPath.fill()
        UIColor.black.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.stroke()
        
        
        //// Group
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath()
        oval2Path.move(to: CGPoint(x: 41.92, y: 86.5))
        oval2Path.addCurve(to: CGPoint(x: 59.5, y: 62), controlPoint1: CGPoint(x: 41.92, y: 72.97), controlPoint2: CGPoint(x: 49.79, y: 62))
        oval2Path.addCurve(to: CGPoint(x: 77.08, y: 86.5), controlPoint1: CGPoint(x: 69.21, y: 62), controlPoint2: CGPoint(x: 77.08, y: 72.97))
        UIColor.white.setFill()
        oval2Path.fill()
        UIColor.black.setStroke()
        oval2Path.lineWidth = 1
        oval2Path.stroke()
        
        
        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 77.5, y: 86.5))
        bezierPath.addLine(to: CGPoint(x: 41.5, y: 86.5))
        UIColor.black.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
        
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

