//
//  TobSubtractionPath.swift
//  Mind > Matter
//
//  Created by Nick Yap on 3/5/16.
//  Copyright © 2016 Toboggan Apps LLC. All rights reserved.
//

import UIKit

/// Creates a subtraction path that is rectangular.
public class TARectangularSubtractionPath: TABaseSubtractionPath {
    /// Padding applied to both the left and the right of ``self.frame``.
    let horizontalPadding: CGFloat
    
    /// Padding applied to both the top and the bottom of ``self.frame``.
    let verticalPadding: CGFloat
    
    public init(frame: CGRect, horizontalPadding: CGFloat = 0, verticalPadding: CGFloat = 0) {
        self.horizontalPadding = horizontalPadding
        self.verticalPadding = verticalPadding
        super.init(frame: frame)
    }
    
    /// Creates a rectangular path with the given padding. The frame is centered in the padding.
    private override func createPath() -> UIBezierPath {
        var rect = self.frame
        
        // Adjust the origin to center the frame in the padding.
        rect.origin.x -= self.horizontalPadding
        rect.origin.y -= self.verticalPadding
        
        // Adjust the width/height for the padding.
        rect.size.width += 2 * self.horizontalPadding
        rect.size.height += 2 * self.verticalPadding
        
        return UIBezierPath(rect: rect)
    }
    
}

/// Creates a subtraction path that is circular.
public class TACircularSubtractionPath: TABaseSubtractionPath {
    
    /// The radius of the circle to subtract.
    let radius: CGFloat
    
    public init(frame: CGRect, radius: CGFloat = 0) {
        self.radius = radius
        super.init(frame: frame)
    }
    
    /// Creates a circular path with the given radius.
    private override func createPath() -> UIBezierPath {
        let rect = CGRectMake(
            CGRectGetMidX(self.frame) - self.radius,
            CGRectGetMidY(self.frame) - self.radius,
            2 * self.radius,
            2 * self.radius)
        
        return UIBezierPath(ovalInRect: rect)
    }
}



/// Base class to be inherited from when creating new path shapes.
public class TABaseSubtractionPath {
    
    /// The frame of the object that will be visible through the overlay.
    let frame: CGRect
    
    /// The path to be subtracted.
    lazy var bezierPath: UIBezierPath = {
        return self.createPath()
    }()
    
    public init(frame: CGRect) {
        self.frame = frame
    }
    
    /// Creates the path that will be subtracted. Override to customize the shape of the path (circular, rectangular, etc.).
    private func createPath() -> UIBezierPath {
        return UIBezierPath()
    }
    
}

