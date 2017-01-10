//
//  ColorUtils.swift
//  Spectrum Brewing
//
//  Created by Connie Lim on 10/22/16.
//  Copyright © 2016 Capstone Fall 2016. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

extension UIImage {
    func getPixelColorBlue(pos: CGPoint = CGPoint(x: 0.0, y: 0.0)) -> CGFloat {
        
        if let pixelData = self.cgImage!.dataProvider!.data {
            let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
            
            let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
            
            //            let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
            //            let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
            let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
            //            let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
            
            return b
        } else {
            assert(false, "unable to read pixel data")
        }
        return 0.0
    }
}

func getSRMValFrom(image img:UIImage) -> Double{
    let context = CIContext(options: nil)
    
    if let currentFilter = CIFilter(name: "CIAreaAverage") {
        let beginImage = CIImage(image: img)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        currentFilter.setValue(CIVector.init(x: 0.0, y: 0.0, z: img.size.height, w: img.size.width), forKey: kCIInputExtentKey)
        
        if let output = currentFilter.outputImage {
            if let cgimg = context.createCGImage(output, from: output.extent) {
                let processedImage = UIImage(cgImage: cgimg)
                // get SRM value from the processed image
                return SRMValFrom(blueColor: processedImage.getPixelColorBlue())
            }
        }
    }
    print("white is returned if filter was not set or image could not be obtained from filter")
    return 0.0
}

func SRMValFrom(blueColor bVal:CGFloat) -> Double{
    let absorbance = log10(bVal/0.267)
    let adj_abs = abs((absorbance*7)-1)
//    here D,(dilution) is set to 1 meaning sample is not diluted
    let SRMVal = 12.7 * 1 * adj_abs
    return Double(SRMVal)
}
