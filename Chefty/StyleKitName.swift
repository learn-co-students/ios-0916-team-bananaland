//
//  StyleKitName.swift
//
//  Created by AuthorName on 11/29/16.
//  Copyright © 2016 CompanyName. All rights reserved.
//
//


import UIKit

public class StyleKitName : NSObject {

    //// Cache

    private struct Cache {
        static var imageOfMainDish: UIImage?
        static var mainDishTargets: [AnyObject]?
    }

    //// Drawing Methods

    public dynamic class func drawMainDish(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 126, height: 145), resizing: ResizingBehavior = .aspectFit) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 126, height: 145), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 126, y: resizedFrame.height / 145)


        //// Color Declarations
        let color = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let color2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Bezier 3 Drawing
        let bezier3Path = UIBezierPath()
        UIColor.white.setStroke()
        bezier3Path.lineWidth = 1
        bezier3Path.stroke()


        //// Main Dish
        //// Outer Oval Drawing
        let outerOvalPath = UIBezierPath(ovalIn: CGRect(x: 17.5, y: 49.5, width: 95, height: 44))
        color.setStroke()
        outerOvalPath.lineWidth = 1
        outerOvalPath.stroke()


        //// Inner Oval Drawing
        let innerOvalPath = UIBezierPath(ovalIn: CGRect(x: 25.5, y: 49.5, width: 79, height: 36))
        UIColor.white.setStroke()
        innerOvalPath.lineWidth = 1
        innerOvalPath.stroke()


        //// Bezier 5 Drawing
        let bezier5Path = UIBezierPath()
        bezier5Path.move(to: CGPoint(x: 90.5, y: 69.74))
        bezier5Path.addCurve(to: CGPoint(x: 90.5, y: 65.26), controlPoint1: CGPoint(x: 90.5, y: 64.36), controlPoint2: CGPoint(x: 90.5, y: 65.26))
        UIColor.white.setStroke()
        bezier5Path.lineWidth = 1
        bezier5Path.stroke()


        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 71.83, y: 54.69))
        bezierPath.addCurve(to: CGPoint(x: 90.5, y: 65.26), controlPoint1: CGPoint(x: 82.46, y: 55.63), controlPoint2: CGPoint(x: 90.5, y: 60.01))
        bezierPath.addCurve(to: CGPoint(x: 67.53, y: 76.02), controlPoint1: CGPoint(x: 90.5, y: 71.2), controlPoint2: CGPoint(x: 80.22, y: 76.02))
        bezierPath.addCurve(to: CGPoint(x: 46.78, y: 69.87), controlPoint1: CGPoint(x: 58.38, y: 76.02), controlPoint2: CGPoint(x: 50.47, y: 73.51))
        bezierPath.addCurve(to: CGPoint(x: 38.5, y: 63.02), controlPoint1: CGPoint(x: 41.76, y: 68.32), controlPoint2: CGPoint(x: 38.5, y: 65.83))
        bezierPath.addCurve(to: CGPoint(x: 58.87, y: 54.5), controlPoint1: CGPoint(x: 38.5, y: 58.31), controlPoint2: CGPoint(x: 47.62, y: 54.5))
        bezierPath.addCurve(to: CGPoint(x: 63.19, y: 54.69), controlPoint1: CGPoint(x: 60.35, y: 54.5), controlPoint2: CGPoint(x: 61.8, y: 54.57))
        bezierPath.addCurve(to: CGPoint(x: 67.53, y: 54.5), controlPoint1: CGPoint(x: 64.6, y: 54.57), controlPoint2: CGPoint(x: 66.05, y: 54.5))
        bezierPath.addCurve(to: CGPoint(x: 71.83, y: 54.69), controlPoint1: CGPoint(x: 69, y: 54.5), controlPoint2: CGPoint(x: 70.44, y: 54.56))
        bezierPath.close()
        UIColor.white.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()


        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 90.5, y: 69.74))
        bezier2Path.addCurve(to: CGPoint(x: 67.53, y: 80.5), controlPoint1: CGPoint(x: 90.5, y: 75.68), controlPoint2: CGPoint(x: 80.22, y: 80.5))
        bezier2Path.addCurve(to: CGPoint(x: 46.78, y: 74.36), controlPoint1: CGPoint(x: 58.38, y: 80.5), controlPoint2: CGPoint(x: 50.47, y: 77.99))
        bezier2Path.addCurve(to: CGPoint(x: 38.5, y: 67.5), controlPoint1: CGPoint(x: 41.76, y: 72.81), controlPoint2: CGPoint(x: 38.5, y: 70.31))
        UIColor.white.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()


        //// Bezier 4 Drawing
        let bezier4Path = UIBezierPath()
        bezier4Path.move(to: CGPoint(x: 38.5, y: 67.95))
        bezier4Path.addLine(to: CGPoint(x: 38.5, y: 62.57))
        UIColor.white.setStroke()
        bezier4Path.lineWidth = 1
        bezier4Path.stroke()


        //// Oval Drawing
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 46.5, y: 58.5, width: 13, height: 5))
        color2.setFill()
        ovalPath.fill()
        UIColor.white.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.stroke()
        
        context.restoreGState()

    }

    public dynamic class func drawSelectedMainDish(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 126, height: 143), resizing: ResizingBehavior = .aspectFit, selected: Bool = true) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        //// Resize to Target Frame
        context.saveGState()
        let resizedFrame: CGRect = resizing.apply(rect: CGRect(x: 0, y: 0, width: 126, height: 143), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 126, y: resizedFrame.height / 143)


        if (selected) {
            //// Main Dish 2
            //// Outer Oval 2 Drawing
            let outerOval2Path = UIBezierPath(ovalIn: CGRect(x: 15.5, y: 47.5, width: 95, height: 44))
            UIColor.white.setFill()
            outerOval2Path.fill()
            UIColor.black.setStroke()
            outerOval2Path.lineWidth = 1
            outerOval2Path.stroke()


            //// Inner Oval 2 Drawing
            let innerOval2Path = UIBezierPath(ovalIn: CGRect(x: 23.5, y: 47.5, width: 79, height: 36))
            UIColor.white.setFill()
            innerOval2Path.fill()
            UIColor.black.setStroke()
            innerOval2Path.lineWidth = 1
            innerOval2Path.stroke()


            //// Bezier 6 Drawing
            let bezier6Path = UIBezierPath()
            bezier6Path.move(to: CGPoint(x: 88.5, y: 67.74))
            bezier6Path.addCurve(to: CGPoint(x: 88.5, y: 63.26), controlPoint1: CGPoint(x: 88.5, y: 62.36), controlPoint2: CGPoint(x: 88.5, y: 63.26))
            UIColor.black.setStroke()
            bezier6Path.lineWidth = 1
            bezier6Path.stroke()


            //// Bezier 7 Drawing
            let bezier7Path = UIBezierPath()
            bezier7Path.move(to: CGPoint(x: 69.83, y: 52.69))
            bezier7Path.addCurve(to: CGPoint(x: 88.5, y: 63.26), controlPoint1: CGPoint(x: 80.46, y: 53.63), controlPoint2: CGPoint(x: 88.5, y: 58.01))
            bezier7Path.addCurve(to: CGPoint(x: 65.53, y: 74.02), controlPoint1: CGPoint(x: 88.5, y: 69.2), controlPoint2: CGPoint(x: 78.22, y: 74.02))
            bezier7Path.addCurve(to: CGPoint(x: 44.78, y: 67.87), controlPoint1: CGPoint(x: 56.38, y: 74.02), controlPoint2: CGPoint(x: 48.47, y: 71.51))
            bezier7Path.addCurve(to: CGPoint(x: 36.5, y: 61.02), controlPoint1: CGPoint(x: 39.76, y: 66.32), controlPoint2: CGPoint(x: 36.5, y: 63.83))
            bezier7Path.addCurve(to: CGPoint(x: 56.87, y: 52.5), controlPoint1: CGPoint(x: 36.5, y: 56.31), controlPoint2: CGPoint(x: 45.62, y: 52.5))
            bezier7Path.addCurve(to: CGPoint(x: 61.19, y: 52.69), controlPoint1: CGPoint(x: 58.35, y: 52.5), controlPoint2: CGPoint(x: 59.8, y: 52.57))
            bezier7Path.addCurve(to: CGPoint(x: 65.53, y: 52.5), controlPoint1: CGPoint(x: 62.6, y: 52.57), controlPoint2: CGPoint(x: 64.05, y: 52.5))
            bezier7Path.addCurve(to: CGPoint(x: 69.83, y: 52.69), controlPoint1: CGPoint(x: 67, y: 52.5), controlPoint2: CGPoint(x: 68.44, y: 52.56))
            bezier7Path.close()
            UIColor.white.setFill()
            bezier7Path.fill()
            UIColor.black.setStroke()
            bezier7Path.lineWidth = 1
            bezier7Path.stroke()


            //// Bezier 8 Drawing
            let bezier8Path = UIBezierPath()
            bezier8Path.move(to: CGPoint(x: 88.5, y: 67.74))
            bezier8Path.addCurve(to: CGPoint(x: 65.53, y: 78.5), controlPoint1: CGPoint(x: 88.5, y: 73.68), controlPoint2: CGPoint(x: 78.22, y: 78.5))
            bezier8Path.addCurve(to: CGPoint(x: 44.78, y: 72.36), controlPoint1: CGPoint(x: 56.38, y: 78.5), controlPoint2: CGPoint(x: 48.47, y: 75.99))
            bezier8Path.addCurve(to: CGPoint(x: 36.5, y: 65.5), controlPoint1: CGPoint(x: 39.76, y: 70.81), controlPoint2: CGPoint(x: 36.5, y: 68.31))
            UIColor.black.setStroke()
            bezier8Path.lineWidth = 1
            bezier8Path.stroke()


            //// Bezier 9 Drawing
            let bezier9Path = UIBezierPath()
            bezier9Path.move(to: CGPoint(x: 36.5, y: 65.95))
            bezier9Path.addLine(to: CGPoint(x: 36.5, y: 60.57))
            UIColor.black.setStroke()
            bezier9Path.lineWidth = 1
            bezier9Path.stroke()


            //// Oval 2 Drawing
            let oval2Path = UIBezierPath(ovalIn: CGRect(x: 44.5, y: 56.5, width: 13, height: 5))
            UIColor.black.setFill()
            oval2Path.fill()
            UIColor.black.setStroke()
            oval2Path.lineWidth = 1
            oval2Path.stroke()


        }
        
        context.restoreGState()

    }

    //// Generated Images

    public dynamic class var imageOfMainDish: UIImage {
        
        
        
        if Cache.imageOfMainDish != nil {
            return Cache.imageOfMainDish!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 126, height: 145), false, 0)
            StyleKitName.drawMainDish()
        
        Cache.imageOfMainDish = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return Cache.imageOfMainDish!
    }

    public dynamic class func imageOfSelectedMainDish(selected: Bool = true) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 126, height: 143), false, 0)
            StyleKitName.drawSelectedMainDish(selected: selected)

        let imageOfSelectedMainDish = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return imageOfSelectedMainDish
    }

    //// Customization Infrastructure

    @IBOutlet dynamic var mainDishTargets: [AnyObject]! {
        get { return Cache.mainDishTargets }
        set {
            Cache.mainDishTargets = newValue
            for target: AnyObject in newValue {
                let _ = target.perform(NSSelectorFromString("setImage:"), with: StyleKitName.imageOfMainDish)
            }
        }
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
