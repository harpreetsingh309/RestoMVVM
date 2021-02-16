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
    @IBOutlet weak var favoriteButton: UIButton!
    var resto: RTRestoViewModel?
    
    override func viewAppear() {
        DispatchQueue.dispatch_async_main {
            self.gradientView.applyGradient()
        }
    }
    
    /// Get layout for collection cell
    override class var layoutClass: AbstractLayout.Type {
        return RTRestoCellLayout.self
    }
    
    /// Show data in  collection cell when loads
    override func updateWithModel(_ model: AnyObject) {
        if let newModel = model as? RTRestoViewModel {
            resto = newModel
            titleLabel.text = newModel.restaurant.name
            addressLabel.text = newModel.address
            restoImgView.image = UIImage(named: newModel.restaurant.image)
            
            // You can use SDWebImage to cache images
            /* if let imgUrl = newModel.image {
                restoImgView.sd_setImage(with: URL(string: imgUrl), placeholderImage: #imageLiteral(resourceName: "ic_carLogo"))
             }*/
        }
    }
    
    @IBAction func favoriteButton(_ sender: Any) {
        if let model = resto {
            if let index = RTAPIManager.sharedInstance.arrayFavourite.firstIndex(where: { $0.restaurant.name == model.restaurant.name }) {
                RTAPIManager.sharedInstance.arrayFavourite.remove(at: index)
                showAlert(msg: AlertMsg.alertFavRemoved)
            } else {
                RTAPIManager.sharedInstance.arrayFavourite.append(model)
                showAlert(msg: AlertMsg.alertFavAdded)
            }
        }
        delegate.updateCell()
    }
    
    private func showAlert(msg: String) {
        UIAlertController.showAlert(AlertMsg.alertTitle, message: msg , buttons: [AlertMsg.alertBtnOK], completion: { (_, index) in })
    }
}
