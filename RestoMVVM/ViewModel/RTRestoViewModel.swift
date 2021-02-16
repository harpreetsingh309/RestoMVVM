//
//  RTRestoViewModel.swift
//  RestoMVVM
//
//  Created by macexpert on 16/02/21.
//

import Foundation

struct RTRestoViewModel: Codable {
    private let restaurant: RestoListModel
    
    var address: String {
        return restaurant.street + ", " + restaurant.city + " " + restaurant.state
    }
}
