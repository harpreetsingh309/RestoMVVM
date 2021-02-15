//
//  Constants.swift
//  RestoMVVM
//
//  Created by macexpert on 15/02/21.
//

import UIKit

/// All constants required in the app
struct Constants {
    static let baseUrl = "https://buttered-pewter.glitch.me"
    static let carListUrl = "/stock/car/test/v1/listing"
}

/// To show alert messages
struct AlertMsg {
    static let alertTitle = "Alert!"
    static let alertBtnOK = "OK"
    static let alertBtnCancel = "Cancel"
    static let noInternet = "The Internet connection appears to be offline."
    static let serverError = "Internal Server error ocurred, try again after some time"
    static let noURlFound = "Url not found!"
}
