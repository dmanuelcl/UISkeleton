//
//  UIView+Skeleton.swift
//  UISkeleton
//
//  Created by Dani Manuel Céspedes Lara on 11/26/17.
//  Copyright © 2017 Speak Slow. All rights reserved.
//

import UIKit
import Skeleton

extension UIView{
    
    class SkeletonGradientLayer: CAGradientLayer{}
    
    private struct associatedKeys {
        static var isSkeletonable: String = "isSkeletonable"
        static var skeletonGradientsColors: String = "skeletonGradientsColors"
        static var isShowingSkeleton: String = "isShowingSkeleton"
        static var animateSkeleton: String = "animateSkeleton"
        static var showOnSkeletonView: String = "showOnSkeletonView"
    }
    
    
    @IBInspectable public var animateSkeleton: Bool{
        get{
            return associatedObject(base: self, key: &associatedKeys.animateSkeleton){
                return true
            }
        }
        set(value){
            associateObject(base: self, key: &associatedKeys.animateSkeleton, value: value)
        }
    }
    
    @IBInspectable public var isSkeletonable: Bool{
        get{
            return associatedObject(base: self, key: &associatedKeys.isSkeletonable){
                return true
            }
        }
        set(value){
            associateObject(base: self, key: &associatedKeys.isSkeletonable, value: value)
        }
    }
    
    @IBInspectable public var showOnSkeletonView: Bool{
        get{
            return associatedObject(base: self, key: &associatedKeys.showOnSkeletonView){
                return true
            }
        }
        set(value){
            associateObject(base: self, key: &associatedKeys.showOnSkeletonView, value: value)
        }
    }
    
    public private(set) var isShowingSkeleton: Bool{
        get{
            return associatedObject(base: self, key: &associatedKeys.isShowingSkeleton){
                return false
            }
        }
        set(value){
            associateObject(base: self, key: &associatedKeys.isShowingSkeleton, value: value)
        }
    }
    
    public var skeletonGradientsColors: [CGColor]{
        get{
            return associatedObject(base: self, key: &associatedKeys.skeletonGradientsColors){
                let baseColor = UIColor(hex: 0xDFDFDF)
                return [baseColor.cgColor, baseColor.brightened(by: 0.93).cgColor, baseColor.cgColor]
            }
        }
        set(value){
            associateObject(base: self, key: &associatedKeys.skeletonGradientsColors, value: value)
        }
    }
    
    func prepareViewsForSkeleton(gradientsColors: [CGColor]) -> [SkeletonGradientLayer]{
        var gradientLayers: [SkeletonGradientLayer] = []
        self.subviews.forEach { (view) in
            if view.isSkeletonable{
                let gradientLayer = SkeletonGradientLayer(layer: view.layer)
                gradientLayer.frame = view.bounds
                gradientLayer.cornerRadius = view.layer.cornerRadius
                gradientLayer.colors = gradientsColors
                view.layer.addSublayer(gradientLayer)
                if view.animateSkeleton{
                    gradientLayers.append(gradientLayer)
                }
                view.isShowingSkeleton = true
            }
            view.isHidden = !view.showOnSkeletonView
            
            gradientLayers += view.prepareViewsForSkeleton(gradientsColors: gradientsColors)
        }
        return gradientLayers
    }
    
    func displaySkeleton(to dir: Direction){
        guard !self.isShowingSkeleton else {return}
        self.isShowingSkeleton = true
        let configuredGradientLayers = self.prepareViewsForSkeleton(gradientsColors: self.skeletonGradientsColors)
        configuredGradientLayers.forEach({ $0.slide(to: dir)})
    }
    
    func removeSkeleton(){
        self.subviews.forEach { (view) in
            if view.isShowingSkeleton{
                view.layer.sublayers?.forEach({ (layer) in
                    if let _ = layer as? SkeletonGradientLayer{
                        layer.removeAllAnimations()
                        layer.removeFromSuperlayer()
                    }
                })
            }
            view.isShowingSkeleton = false
            if view.isHidden && !view.showOnSkeletonView{
                view.isHidden = false
            }
        }
    }
    
}
