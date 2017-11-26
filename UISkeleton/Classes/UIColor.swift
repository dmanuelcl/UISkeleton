//
//  UIColor.swift
//  UISkeleton
//
//  Created by Dani Manuel on 9/7/17.
//  Copyright © 2017 Dani Manuel. All rights reserved.
//

import UIKit

extension UIColor{
    
    convenience init(red: Int64, green: Int64, blue: Int64) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        if #available(iOS 10.0, *) {
            self.init(displayP3Red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        } else {
            self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
        }
    }
    
    convenience init(hex: Int64) {
        self.init(red: (hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff)
    }
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor{
        var color = UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
        if #available(iOS 10.0, *) {
            color = UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: 1)
        }
        return color
    }
    
    func brightened(by factor: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: h, saturation: s, brightness: b * factor, alpha: a)
    }
    
}
