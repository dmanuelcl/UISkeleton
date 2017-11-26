//
//  SkeletonTableViewDataSource.swift
//  UISkeleton
//
//  Created by Dani Manuel Céspedes Lara on 11/26/17.
//

import UIKit

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

