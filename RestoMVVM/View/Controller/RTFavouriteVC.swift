//
//  RTFavouriteVC.swift
//  RestoMVVM
//
//  Created by macexpert on 16/02/21.
//

import UIKit

class RTFavouriteVC: AbstractController {
    
    override var collectionClass: AbstractCollectionListController.Type! {
        return RTFavouriteListVC.self
    }
}
