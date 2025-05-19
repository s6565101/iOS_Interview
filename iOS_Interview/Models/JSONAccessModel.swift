//
//  Application: iOS_InterView
//  File Name  : JSONAccessModel.swift
//  Author     : Jane Wu
//  Revise Date: 2024/05/16
//

import Foundation

//Notification text
struct NotificationList: Decodable {
    let msgCode: String
    let msgContent: String
    let result: MessageResult
}

struct MessageResult: Decodable {
    let messages: [NotificationMessage]
}

struct NotificationMessage: Decodable {
    let status: Bool
    let updateDateTime: String
    let title: String
    let message: String
}

//First open amount
struct FirstOpenAccount: Codable {
    let account: String
    let curr: String
    let balance: Double
}

struct FirstOpenAccountResponse: Codable {
    let msgCode: String
    let msgContent: String
    let result: FirstOpenAccountResult
}

struct FirstOpenAccountResult: Codable {
    let savingsList: [FirstOpenAccount]?
    let fixedDepositList: [FirstOpenAccount]?
    let digitalList: [FirstOpenAccount]?
}

//Pull refresh amount
struct PullRefreshAccount: Codable {
    let account: String
    let curr: String
    let balance: Double
}

struct PullRefreshAccountResponse: Codable {
    let msgCode: String
    let msgContent: String
    let result: PullRefreshAccountResult
}

struct PullRefreshAccountResult: Codable {
    let savingsList: [PullRefreshAccount]?
    let fixedDepositList: [PullRefreshAccount]?
    let digitalList: [FirstOpenAccount]?
}


