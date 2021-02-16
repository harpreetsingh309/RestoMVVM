//
//  RTRestoDataModel.swift
//  RestoMVVM
//
//  Created by macexpert on 16/02/21.
//

import Foundation

struct RTRestoDataModel: Codable {
    let message: String
    let success: Int
    let list : [RestoListModel]
}

struct RestoListModel: Codable {
    let name: String
    let image: String
    let street: String
    let city: String
    let state: String
}
