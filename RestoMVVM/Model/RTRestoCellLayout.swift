//
//  RTRestoCellLayout.swift
//  RestoMVVM
//
//  Created by macexpert on 16/02/21.
//

import UIKit
/*
 FlowLayout for Car Listing
 */
class RTRestoCellLayout: AbstractLayout {
    
    // MARK: - Override variables
    override func initView() {
        super.initView()
        scrollDirection = .vertical
    }
    
    override var aspectRatio: CGFloat {
        return 0.6
    }
    
    override var rows: CGFloat {
        return 1
    }
    
    override var minLineSpace: CGFloat {
        return 0
    }
}
