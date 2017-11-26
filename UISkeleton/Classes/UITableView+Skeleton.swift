//
//  UITableView+Skeleton.swift
//  UISkeleton
//
//  Created by Dani Manuel Céspedes Lara on 11/26/17.
//

import UIKit
import Skeleton


class SkeletonTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    //    MARK: DataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(ceil(UIScreen.main.bounds.height/tableView.rowHeight))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reusableIdentifier = tableView.reusableIdentifier, let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier) else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    //    MARK: Delegate
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.displaySkeleton(to: .right)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.removeSkeleton()
    }
}


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
    }
    
    public func hideSkeletonView(){
        self.delegate = self.realDelegate
        self.dataSource = self.realDataSource
        self.reloadData()
    }
}
