//
//  Application: iOS_InterView
//  File Name  : RefreshViewModel.swift
//  Author     : Jane Wu
//  Revise Date: 2025/05/18
//

import UIKit
import Foundation

class RefreshViewModel: NSObject {
    
    var dataSourceModel = DataSourceModel()
    
    var didItRefresh: Bool = false
    var eyeOpen: Bool = true
    
    //Save for Notification JSON
    var tableCount: Int = 0
    var readed: [Bool] = []
    var titleText: [String] = []
    var sendTimeText: [String] = []
    var contentText: [String] = []
    
    //Save for Notification JSON
    var firstOpenUSD: String = ""
    var firstOpenKHR: String = ""
    var pullRefreshUSD: String = ""
    var pullRefreshKHR: String = ""
    
    func refresh() {
        didItRefresh = true
        }
    
    func changeEye() {
        if eyeOpen {
            eyeOpen = false
        } else {
            eyeOpen = true
        }
    }
    
    func FetchNotificationData(groupKey: String, completion: @escaping (Double) -> Void) {
        var totalAmount: Double = 0
        guard let urls = dataSourceModel.theAmountURLs[groupKey] else {
                completion(0)
                return
            }
        for (amountType, urlString) in urls {
            guard let url = URL(string: urlString) else {
                    continue
                }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
     
                    do {
                        let decoded = try JSONDecoder().decode(FirstOpenAccountResponse.self, from: data)
                        let list: [FirstOpenAccount]
                        
                        switch amountType {
                        case "saving":
                            list = decoded.result.savingsList ?? []
                        case "fixed":
                            list = decoded.result.fixedDepositList ?? []
                        case "digital":
                            list = decoded.result.digitalList ?? []
                        default:
                            return
                        }
                        DispatchQueue.main.async {
                            for i in list {
                                totalAmount += i.balance
                            }
                            completion(totalAmount)
                        }
                    } catch {
                        completion(0)
                    }
                } else if error != nil {
                    completion(0)
                }
            }.resume()
        }
        
    }
    
    func FormatWithComma(_ number: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)"
    }
   
}
