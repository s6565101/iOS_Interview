//
//  Application: iOS_InterView
//  File Name  : ViewController.swift
//  Author     : Jane Wu
//  Revise Date: 2024/05/18
//

import UIKit

class ViewController: UIViewController {

    var refreshControl = UIRefreshControl()
    
    var refreshViewModel = RefreshViewModel()
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var scrolView: UIScrollView!
    
    @IBOutlet weak var eyeButton: UIButton!
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    @IBOutlet weak var bellButton: UIButton!
    
    @IBOutlet weak var USDLabel: UILabel!
    
    @IBOutlet weak var USDMoneyLabel: UILabel!
    
    @IBOutlet weak var KHRLabel: UILabel!
    
    @IBOutlet weak var KHRMoneyLabel: UILabel!
    
    @IBOutlet weak var transferLabel: UILabel!
    
    @IBOutlet weak var paymentLabel: UILabel!
    
    @IBOutlet weak var utilityLabel: UILabel!
    
    @IBOutlet weak var QRPayScanLabel: UILabel!
    
    @IBOutlet weak var MyQrCodeLabel: UILabel!
    
    @IBOutlet weak var TopUpLabel: UILabel!
    
    @IBOutlet weak var MyFavoriteLabel: UILabel!
    
    @IBOutlet weak var favoriteEmptyLabel: UILabel!
    
    @IBOutlet weak var MoreLabel: UILabel!
    
    @IBOutlet weak var mobileLabel: UILabel!
 
    @IBOutlet weak var CUBDLabel: UILabel!
    
    @IBOutlet weak var creditCardLabel: UILabel!
    
    @IBOutlet weak var PMFLabel: UILabel!
    
    @IBOutlet weak var CUBD_2Label: UILabel!
    
    @IBOutlet weak var favoriteEmptyView: UIView!

    @IBOutlet weak var favoriteView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var pageScrollView: UIScrollView!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBAction func eyeButton(_ sender: Any) {
        
        refreshViewModel.changeEye()
        var eyeIconName: String {
            refreshViewModel.eyeOpen ?  "iconEye01On" : "iconEye02Off"
            }
        
        let eyeImage = UIImage(named: eyeIconName)?.withRenderingMode(.alwaysOriginal)
        eyeButton.setImage(eyeImage, for: .normal)
        if eyeIconName == "iconEye02Off" {
            USDMoneyLabel.text = "********"
            KHRMoneyLabel.text = "********"
        } else if eyeIconName == "iconEye01On" {
            
            if refreshViewModel.didItRefresh {
                self.USDMoneyLabel.text = self.refreshViewModel.pullRefreshUSD
                self.KHRMoneyLabel.text = self.refreshViewModel.pullRefreshKHR
            } else {
                self.USDMoneyLabel.text = self.refreshViewModel.firstOpenUSD
                self.KHRMoneyLabel.text = self.refreshViewModel.firstOpenKHR
            }
        }
        
    }
    
    @IBAction func BellButtonPress(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
        let notificationVC = NotificationViewController()
        
            notificationVC.refreshViewModel = self.refreshViewModel
        
        self.navigationController?.pushViewController(notificationVC, animated: true)
        
    }
    
    @IBAction func changPage(_ sender: UIPageControl) {
        
        scrollToPage(pageIndex: sender.currentPage)
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        balanceLabel.font = .textStyle10
        USDLabel.font = .textStyle2
        USDMoneyLabel.font = .textStyle3
        KHRLabel.font = .textStyle2
        KHRMoneyLabel.font = .textStyle3
        transferLabel.font = .textStyle4
        paymentLabel.font = .textStyle4
        utilityLabel.font = .textStyle4
        QRPayScanLabel.font = .textStyle4
        MyQrCodeLabel.font = .textStyle4
        TopUpLabel.font = .textStyle4
        MyFavoriteLabel.font = .textStyle10
        MoreLabel.font = .textStyle2
        mobileLabel.font = .textStyle7
        CUBDLabel.font = .textStyle7
        creditCardLabel.font = .textStyle7
        PMFLabel.font = .textStyle7
        CUBD_2Label.font = .textStyle7
        
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 0.5
        bottomView.layer.cornerRadius = 30
        bottomView.layer.shadowOffset = CGSize(width: 0, height: 2)
        bottomView.layer.shadowRadius = 6
        bottomView.layer.masksToBounds = false
        
        bottomView.layer.zPosition = .greatestFiniteMagnitude //put view to top
        
        let timerProgress = UIPageControlTimerProgress(preferredDuration: 3)
        pageControl.progress = timerProgress
        timerProgress.resetsToInitialPageAfterEnd = true
        timerProgress.resumeTimer()
        timerProgress.currentProgress = 1
        timerProgress.delegate = self
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.addTarget(self, action: #selector(refreshView), for: UIControl.Event.valueChanged)
        scrolView.refreshControl = refreshControl
        
        if let url = URL(string: "https://willywu0201.github.io/data/notificationList.json") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    do {
                        let decoded = try JSONDecoder().decode(NotificationList.self, from: data)
                        let response = decoded.result.messages
                        self.refreshViewModel.tableCount = response.count
                        
                        for i in response {
                            self.refreshViewModel.readed.append(i.status)
                            self.refreshViewModel.titleText.append(i.title)
                            self.refreshViewModel.sendTimeText.append(i.updateDateTime)
                            self.refreshViewModel.contentText.append(i.message)
                        }
                        
                    } catch {
                        print("Error ：\(error.localizedDescription)")
                    }
                }
            }.resume()
        }

        
        self.refreshViewModel.FetchNotificationData(groupKey: "firstOpen_USD") { total in
            let firstOpenUSD = self.refreshViewModel.FormatWithComma(total)
            self.refreshViewModel.firstOpenUSD = firstOpenUSD
            self.USDMoneyLabel.text = String(firstOpenUSD)
        }
        
        self.refreshViewModel.FetchNotificationData(groupKey: "firstOpen_KHR") { total in
            let firstOpenKHR = self.refreshViewModel.FormatWithComma(total)
            self.refreshViewModel.firstOpenKHR = firstOpenKHR
            self.KHRMoneyLabel.text = String(firstOpenKHR)
        }
        
        self.refreshViewModel.FetchNotificationData(groupKey: "pullRefresh_USD") { total in
            let pullRefreshUSD = self.refreshViewModel.FormatWithComma(total)
            self.refreshViewModel.pullRefreshUSD = pullRefreshUSD
        }
        
        self.refreshViewModel.FetchNotificationData(groupKey: "pullRefresh_KHR") { total in
            let pullRefreshKHR = self.refreshViewModel.FormatWithComma(total)
            self.refreshViewModel.pullRefreshKHR = pullRefreshKHR
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if segue.identifier == "toNotificationVC" {
                if let destination = segue.destination as? NotificationViewController {
                    destination.refreshViewModel = self.refreshViewModel
                }
            }
        
        }
    
    @objc func refreshView() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            refreshViewModel.refresh()
            self.refreshControl.endRefreshing()
            if refreshViewModel.didItRefresh {
                
                let bellImage = UIImage(named: "iconBell02Active")?.withRenderingMode(.alwaysOriginal)
                bellButton.setImage(bellImage, for: .normal)
                
                self.USDMoneyLabel.text = self.refreshViewModel.pullRefreshUSD
                self.KHRMoneyLabel.text = self.refreshViewModel.pullRefreshKHR
                
                self.favoriteEmptyView.isHidden = true
                self.favoriteView.isHidden = false
            }
        }
        
    }
    
    @objc func timingChangPage(_ sender: UIPageControl) {
        
        let timerProgress = UIPageControlTimerProgress(preferredDuration: 3)
        pageControl.progress = timerProgress
        timerProgress.resetsToInitialPageAfterEnd = true
        timerProgress.resumeTimer()
        
    }

    func scrollToPage(pageIndex: Int, animated: Bool = true) {
        
        let point = CGPoint(x: pageScrollView.bounds.width * CGFloat(pageIndex), y: 0)
        pageScrollView.setContentOffset(point, animated: animated)
        
    }

}



