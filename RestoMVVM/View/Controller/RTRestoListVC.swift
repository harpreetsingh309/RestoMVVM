//
//  RTRestoListVC.swift
//  RestoMVVM
//
//  Created by macexpert on 16/02/21.
//

import UIKit

class RTRestoListVC: AbstractCollectionListController {
    
    /// To register collection view cell class
    override var cellClass: AbstractCollectionCell.Type {
        return RTRestoCVCell.self
    }
    
    //MARK: - Get Data
    /// Get data from server and call when view did load  and show in collection cell
    override func requestItems(_ query: String, page: Int, completion: @escaping (Array<Any>?, NSError?, Bool?) -> Void) {
        collectionView.isPagingEnabled = false
        if let array = RTAPIManager.sharedInstance.getJsonFileData(Constants.jsonFile) {
            completion(array, nil, false)
        } else {
            self.noItemsText = AlertMsg.noDataFound
            completion([], nil, false)
        }
    }
}
