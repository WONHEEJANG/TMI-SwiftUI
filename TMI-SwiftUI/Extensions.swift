//
//  Extensions.swift
//  TMI-SwiftUI
//
//  Created by Jason on 2021/12/16.
//

import Foundation
import SwiftUI

let Global_Padding = UIScreen.screenWidth * 0.1

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

// List Seperator Hidden
extension EdgeInsets {
    static let defaultListRowInsets = Self(top: 0, leading: 16, bottom: 0, trailing: 16)
}

// emoji to color

extension UILabel {
    var toImage :UIImage?{
        UIGraphicsBeginImageContext(self.frame.size)
        print("self.frame.size:\(self.frame.size)")
        print("self.frame.minX:\(self.frame.minX)")
        print("self.frame.minY:\(self.frame.minY)")
        if let currentContext = UIGraphicsGetCurrentContext() {
            self.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
    
}

extension UIImage {
    var averageColor: UIColor? {
        guard let inputImage = CIImage(image: self) else {
            return nil
        }
        
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard
            let filter = CIFilter(
                name: "CIAreaAverage",
                parameters: [
                    kCIInputImageKey: inputImage,
                    kCIInputExtentKey: extentVector
                ]
            ),
            let outputImage = filter.outputImage else {
            return nil
        }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull!])
        context.render(
            outputImage,
            toBitmap: &bitmap,
            rowBytes: 4,
            bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
            format: .RGBA8,
            colorSpace: nil
        )
        print("origin_bitmap:\(bitmap)")
        
        //        for index in 0...2{
        //            bitmap[index] += UInt8(CGFloat(255 - bitmap[index]) * 0.7)
        //        }
        
        let bitmapAvg = UInt8((CGFloat(bitmap[0])/255 + CGFloat(bitmap[1])/255 + CGFloat(bitmap[2])/255) / 3 * 255)
        for index in 0...2{
            if bitmap[index] > bitmapAvg {
                bitmap[index] = 255
            }
        }
        
        print("bitmapAvg:\(bitmapAvg)")
        print("bitmap:\(bitmap)")
        
        let ratio:CGFloat = 0.95
        
        return UIColor(
            red: CGFloat(bitmap[0]) / 255 * ratio,
            green: CGFloat(bitmap[1]) / 255 * ratio,
            blue: CGFloat(bitmap[2]) / 255 * ratio,
            alpha: CGFloat(bitmap[3]) / 255 * ratio
        )
    }
}

//N넘으면 255로 극대화 시키자

extension UIColor {
    /// The SwiftUI color associated with the receiver.
    var suColor: Color { Color(self) }
}
