//
//  RTFavouriteListVC.swift
//  RestoMVVM
//
//  Created by macexpert on 16/02/21.
//

import UIKit

class RTFavouriteListVC: AbstractCollectionListController {
        
    override func viewWillAppear(_ animated: Bool) {
        refresh()
    }
    
    /// To register collection view cell class
    override var cellClass: AbstractCollectionCell.Type {
        return RTRestoCVCell.self
    }
    
    //MARK: - Data
    /// Get data from server and call when view did load  and show in collection cell
    override func requestItems(_ query: String, page: Int, completion: @escaping (Array<Any>?, NSError?, Bool?) -> Void) {
        if RTAPIManager.sharedInstance.arrayFavourite.isEmpty {
            self.noItemsText = AlertMsg.emptyFav
            completion([], nil, false)
        }
        completion(RTAPIManager.sharedInstance.arrayFavourite, nil, false)
    }
    
    override func updateCell() {
        refresh()
    }
}
