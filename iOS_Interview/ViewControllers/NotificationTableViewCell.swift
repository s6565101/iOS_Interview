//
//  Application: iOS_InterView
//  File Name  : NotificationTableViewCell.swift
//  Author     : Jane Wu
//  Revise Date: 2025/05/18
//

import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var sendTimeLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var readStatus: UIImageView!
    
    override func awakeFromNib() {
        
            super.awakeFromNib()
            titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            sendTimeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            contentLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        }
    
}
