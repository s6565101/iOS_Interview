//
//  Application: iOS_InterView
//  File Name  : NotificationViewController.swift
//  Author     : Jane Wu
//  Revise Date: 2024/05/18
//

import UIKit

class NotificationViewController: UITableViewController {
    
    var tableSource = DataSourceModel()
    var refreshViewModel: RefreshViewModel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tableCount = 0
        if refreshViewModel.didItRefresh {
            tableCount = refreshViewModel.tableCount
        }
        
        return tableCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let tableCell = tableView.dequeueReusableCell(withIdentifier: "datacell", for: indexPath) as? NotificationTableViewCell else {
                fatalError("Could not dequeue NotificationTableViewCell with identifier 'datacell'")
            }
        if refreshViewModel.didItRefresh {
            tableCell.readStatus.isHidden = !refreshViewModel!.readed[indexPath.row]
            tableCell.titleLabel.text = refreshViewModel!.titleText[indexPath.row]
            tableCell.sendTimeLabel.text = refreshViewModel!.sendTimeText[indexPath.row]
            tableCell.contentLabel.text = refreshViewModel!.contentText[indexPath.row]
        }
        
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
}
