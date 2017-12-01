//
//  UITableView+Skeleton.swift
//  UISkeleton
//
//  Created by Dani Manuel Céspedes Lara on 11/26/17.
//

import UIKit
import Skeleton

extension UITableView{
    
    private struct associatedKeys {
        static var realDataSource: String = "realDataSource"
        static var realDelegate: String = "realDelegate"
        static var skeletonCellIdentifier: String = "skeletonCellIdentifier"
        static var skeletonDataSource: String = "skeletonDataSource"
    }
    
    
    var skeletonCellIdentifier: String?{
        get{
            return associatedObject(base: self, key: &associatedKeys.skeletonCellIdentifier){
                return nil
            }
        }
        set(value){
            associateObject(base: self, key: &associatedKeys.skeletonCellIdentifier, value: value)
        }
    }
    
    
    var skeletonDataSource: SkeletonTableViewDataSource?{
        get{
            return associatedObject(base: self, key: &associatedKeys.skeletonDataSource){
                return nil
            }
        }
        set(value){
            associateObject(base: self, key: &associatedKeys.skeletonDataSource, value: value)
        }
    }
    
    var realDataSource: UITableViewDataSource?{
        get{
            return associatedObject(base: self, key: &associatedKeys.realDataSource){
                return nil
            }
        }
        set(value){
            associateObject(base: self, key: &associatedKeys.realDataSource, value: value)
        }
    }
    
    var realDelegate: UITableViewDelegate?{
        get{
            return associatedObject(base: self, key: &associatedKeys.realDelegate){
                return nil
            }
        }
        set(value){
            associateObject(base: self, key: &associatedKeys.realDelegate, value: value)
        }
    }
    
    public func showSkeletonView(skeletonCellIdentifier: String, direction: Direction = .right){
        self.realDelegate = self.delegate
        self.realDataSource = self.dataSource
        self.isScrollEnabled = false
        self.isUserInteractionEnabled = false
        self.skeletonCellIdentifier = skeletonCellIdentifier
        
        self.skeletonDataSource = SkeletonTableViewDataSource()
        self.dataSource = self.skeletonDataSource
        self.delegate = self.skeletonDataSource
        self.reloadData()
    }
    
    public func hideSkeletonView(){
        self.visibleCells.forEach { (cell) in
            cell.removeSkeleton()
        }
        self.delegate = self.realDelegate
        self.dataSource = self.realDataSource
        self.isScrollEnabled = true
        self.isUserInteractionEnabled = true
        self.reloadData()
    }
}
