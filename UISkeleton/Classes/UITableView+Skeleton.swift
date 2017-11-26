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
        static var reusableIdentifier: String = "reusableIdentifier"
    }
    
    
    var reusableIdentifier: String?{
        get{
            return associatedObject(base: self, key: &associatedKeys.reusableIdentifier){
                return nil
            }
        }
        set(value){
            associateObject(base: self, key: &associatedKeys.reusableIdentifier, value: value)
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
    
    public func showSkeletonView(reusableIdentifier: String, direction: Direction = .right){
        self.realDelegate = self.delegate
        self.realDataSource = self.dataSource
        
        let skletonDataStore = SkeletonTableViewDataSource()
        self.dataSource = skletonDataStore
        self.delegate = skletonDataStore
        self.isScrollEnabled = false
    }
    
    public func hideSkeletonView(){
        self.delegate = self.realDelegate
        self.dataSource = self.realDataSource
        self.isScrollEnabled = true
        self.reloadData()
    }
}
