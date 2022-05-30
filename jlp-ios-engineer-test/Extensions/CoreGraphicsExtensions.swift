//
//  CoreGraphics+Scaling.swift
//  Facivacy
//
//  Created by Matthew Reddin on 07/06/2020.
//  Copyright © 2020 Matthew Reddin. All rights reserved.
//

import Foundation
import CoreGraphics

extension CGImage {
    func scaleImage(maxSide: CGFloat) -> CGImage? {
        let ratio = CGFloat(self.height) / CGFloat(self.width)
        let height: CGFloat
        let width: CGFloat
        if self.height > self.width {
            height = min(maxSide, CGFloat(self.height))
            width = height / ratio
        } else {
            width = min(maxSide, CGFloat(self.width))
            height = width * ratio
        }
        let ctxt = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: self.bitsPerComponent, bytesPerRow: 0, space: colorSpace ?? CGColorSpaceCreateDeviceRGB(), bitmapInfo: self.bitmapInfo.rawValue)
        ctxt?.interpolationQuality = .high
        ctxt?.draw(self, in: CGRect(origin: .zero, size: .init(width: width, height: height)))
        return ctxt?.makeImage()
    }
}
