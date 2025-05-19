//
//  Application: iOS_InterView
//  File Name  : DataSourceModel.swift
//  Author     : Jane Wu
//  Revise Date: 2024/05/16
//

import UIKit
import Foundation

class DataSourceModel: NSObject {
    
    let signs: [String] = ["banner1", "banner2", "banner3", "banner4", "banner5"]
    
    let notificationlistURLs: [String: String] = [
        "empty": "https://willywu0201.github.io/data/emptyNotificationList.json",
        "notEmpty": "https://willywu0201.github.io/data/notificationList.json",
    ]
    
    let theAmountURLs: [String: [String: String]] = [
        "firstOpen_USD": [
            "saving": "https://willywu0201.github.io/data/usdSavings1.json",
            "fixed": "https://willywu0201.github.io/data/usdFixed1.json",
            "digital": "https://willywu0201.github.io/data/usdDigital1.json"
        ],
        "firstOpen_KHR": [
            "saving": "https://willywu0201.github.io/data/khrSavings1.json",
            "fixed": "https://willywu0201.github.io/data/khrFixed1.json",
            "digital": "https://willywu0201.github.io/data/khrDigital1.json"
        ],
        "pullRefresh_USD": [
            "saving": "https://willywu0201.github.io/data/usdSavings2.json",
            "fixed": "https://willywu0201.github.io/data/usdFixed2.json",
            "digital": "https://willywu0201.github.io/data/usdDigital2.json"
        ],
        "pullRefresh_KHR": [
            "saving": "https://willywu0201.github.io/data/khrSavings2.json",
            "fixed": "https://willywu0201.github.io/data/khrFixed2.json",
            "digital": "https://willywu0201.github.io/data/khrDigital2.json"
        ]
    ]
    
}
