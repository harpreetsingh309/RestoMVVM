//
//  RTAPIManager.swift
//  RestoMVVM
//
//  Created by macexpert on 16/02/21.
//

import UIKit

class RTAPIManager {
    
    static let sharedInstance = RTAPIManager()
    var activityView: UIActivityIndicatorView?
    
    // MARK:- Get data from JSON file
    func getJsonFileData<T:Decodable>(_ fileName: String, completion: @escaping (T) -> ()) {
        showActivityIndicator()
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            let decoder = JSONDecoder()
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                hideActivityIndicator()
                let decodedData = try decoder.decode(T.self, from: data)
//                if let decode = decodedData as? RTRestoDataModel {
//                    let model: RTRestoViewModel = decode.list.map { $0 }
//                }
                completion(decodedData)
            } catch {
                print("Unable to load data")
                hideActivityIndicator()
                self.showAlert(AlertMsg.serverError)
              }
        }
    }
    
    /// In case to call API and get data
    // MARK:- URLSession Task
/*
    private func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {[weak self] (data, response, error) in
                if error != nil {
                    self?.hideActivityIndicator()
                    self?.delegate?.didFailWithError(error: Errors.serverError)
                    return
                }
                if let safeData = data {
                    if let weather = safeData {
                        // Comment:- Convert Json data to model (JSON Serialisation) and sending data via delegates
                        self?.hideActivityIndicator()
                        self?.delegate?.didUpdateBulkWeather(self!, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
*/
    
    func showAlert(_ msg: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            UIAlertController.showAlert(AlertMsg.alertTitle, message: msg , buttons: [AlertMsg.alertBtnOK], completion: { (_, index) in })
        }
    }
    
    // MARK:-  Activity Indicator
    private func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.color = .black
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.activityView!.center = UIApplication.scene.view.center
            UIApplication.scene.view.addSubview(self.activityView!)
            self.activityView!.startAnimating()
        }
    }
    
    private func hideActivityIndicator(){
        if (activityView != nil){
            DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                self.activityView?.stopAnimating()
            }
        }
    }
}
