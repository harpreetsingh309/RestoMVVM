//
//  RTRestoVC.swift
//  RestoMVVM
//
//  Created by macexpert on 16/02/21.
//

import UIKit

class RTRestoVC: AbstractController {
    
    override var collectionClass: AbstractCollectionListController.Type! {
        return RTRestoListVC.self
    }
}
