//
//  CustomLayoutView.swift
//  Chefty
//
//  Created by Arvin San Miguel on 11/17/16.
//  Copyright © 2016 com.AppRising.SML. All rights reserved.
//

import UIKit

class CustomLayoutView: UICollectionViewLayout {
    
    var numberOfColumns = 2
    var cellPadding : CGFloat = 6.0
    
    private var cache = [UICollectionViewLayoutAttributes]()
    private var contentHeight : CGFloat = 0.0
    private var contentWidth : CGFloat {
        let insets = collectionView!.contentInset
        return collectionView!.bounds.width - (insets.left + insets.right)
    }
    
    override func prepare() {
        
        if cache.isEmpty {
            
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            var xOffset = [CGFloat]()
            
            for column in 0..<numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            
            var column = 0
            var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
            
            var photoHeight : [CGFloat] = [150.13, 200.14, 250,23]
            //var photoHeight : [CGFloat] = [(collectionView?.frame.height)! * 0.30, (collectionView?.frame.height)! * 0.60, (collectionView?.frame.height)! * 0.44 ]
            
            var arr = 0
            
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                
                let indexPath = NSIndexPath(item: item, section: 0)
                
                let height = cellPadding + photoHeight[arr] + cellPadding
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath as IndexPath)
                attributes.frame = insetFrame
                cache.append(attributes)
                
                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + height
                
                column = column >= (numberOfColumns - 1) ? 0 : 1
                if arr == 2 { arr = 0 } else { arr += 1 }
            }
            
        }
        
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
        
    }
    
}
