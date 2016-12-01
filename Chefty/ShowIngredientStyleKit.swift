//
//  ShowIngredientStyleKit.swift
//  Chefty
//
//  Created by Arvin San Miguel on 12/1/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import Foundation
import UIKit

public class ShowIngredientStyleKit : NSObject {
    
    //// Drawing Methods
    
    public dynamic class func drawShowIngredients(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 130, height: 130), resizing: ResizingBehavior = .aspectFit) {
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
        bezierPath.move(to: CGPoint(x: 52, y: 62.5))
        bezierPath.addCurve(to: CGPoint(x: 90.5, y: 62.5), controlPoint1: CGPoint(x: 90.54, y: 62.5), controlPoint2: CGPoint(x: 90.5, y: 62.5))
        UIColor.white.setStroke()
        bezierPath.lineWidth = 3.5
        bezierPath.stroke()
        
        
        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 52, y: 76.5))
        bezier2Path.addCurve(to: CGPoint(x: 90.5, y: 76.5), controlPoint1: CGPoint(x: 90.54, y: 76.5), controlPoint2: CGPoint(x: 90.5, y: 76.5))
        UIColor.white.setStroke()
        bezier2Path.lineWidth = 3.5
        bezier2Path.stroke()
        
        
        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        bezier3Path.move(to: CGPoint(x: 52, y: 49))
        bezier3Path.addCurve(to: CGPoint(x: 90.5, y: 49), controlPoint1: CGPoint(x: 90.54, y: 49), controlPoint2: CGPoint(x: 90.5, y: 49))
        UIColor.white.setStroke()
        bezier3Path.lineWidth = 3.5
        bezier3Path.stroke()
        
        
        //// Oval 2 Drawing
        let oval2Path = UIBezierPath(ovalIn: CGRect(x: 44, y: 48, width: 2, height: 2))
        UIColor.white.setFill()
        oval2Path.fill()
        UIColor.white.setStroke()
        oval2Path.lineWidth = 3.5
        oval2Path.stroke()
        
        
        //// Oval 3 Drawing
        let oval3Path = UIBezierPath(ovalIn: CGRect(x: 44, y: 61, width: 2, height: 2))
        UIColor.white.setFill()
        oval3Path.fill()
        UIColor.white.setStroke()
        oval3Path.lineWidth = 3.5
        oval3Path.stroke()
        
        
        //// Oval 4 Drawing
        let oval4Path = UIBezierPath(ovalIn: CGRect(x: 44, y: 75, width: 2, height: 2))
        UIColor.white.setFill()
        oval4Path.fill()
        UIColor.white.setStroke()
        oval4Path.lineWidth = 3.5
        oval4Path.stroke()
        
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
