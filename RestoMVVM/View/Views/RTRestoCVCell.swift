//
//  RTRestoCVCell.swift
//  RestoMVVM
//
//  Created by macexpert on 16/02/21.
//

import UIKit

class RTRestoCVCell: AbstractCollectionCell {

    @IBOutlet weak var restoImgView: UIImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    override func initViews() {
        gradientView.applyGradient()
    }

    /// Get layout for collection cell
    override class var layoutClass: AbstractLayout.Type {
        return RTRestoCellLayout.self
    }

    /// Show data in  collection cell when loads
    override func updateWithModel(_ model: AnyObject) {
        if let newModel = model as? RestoListModel {
            titleLabel.text = newModel.name
//            addressLabel.text = newModel.address
            restoImgView.image = UIImage(named: newModel.image)
            
            // Can you SDWebImage to cache images
            
//            if let imgUrl = newModel.image {
//                restoImgView.sd_setImage(with: URL(string: imgUrl), placeholderImage: #imageLiteral(resourceName: "ic_carLogo"))
//            }
        }
    }
}
