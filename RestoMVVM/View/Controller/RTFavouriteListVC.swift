//
//  RTFavouriteListVC.swift
//  RestoMVVM
//
//  Created by macexpert on 16/02/21.
//

import UIKit

class RTFavouriteListVC: AbstractCollectionListController {
    
    /// To register collection view cell class
    override var cellClass: AbstractCollectionCell.Type {
        return RTRestoCVCell.self
    }
    
    //MARK: - Data
    /// Get data from server and call when view did load  and show in collection cell
    override func requestItems(_ query: String, page: Int, completion: @escaping (Array<Any>?, NSError?, Bool?) -> Void) {
        collectionView.isPagingEnabled = false
        RTAPIManager.sharedInstance.getJsonFileData(Constants.jsonFile, completion: { [weak self] (model : RTRestoDataModel?) in
            if let item = model?.list, item.count > 0 {
                completion(item,nil,false)
            } else {
                self?.noItemsText = AlertMsg.noDataFound
                completion([],nil,false)
            }
        })
    }
}
