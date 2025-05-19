//
//  Application: iOS_InterView
//  File Name  : PageControlExtension.swift
//  Author     : Jane Wu
//  Revise Date: 2024/05/12
//

import UIKit
import Foundation

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = (scrollView.contentOffset.x / scrollView.bounds.width)
        pageControl.currentPage = Int(page.rounded())
    }
    
}

extension ViewController: UIPageControlTimerProgressDelegate {
    
    func pageControlTimerProgress(_ progress: UIPageControlTimerProgress, shouldAdvanceToPage page: Int) -> Bool {
        image.image = UIImage(named: DataSourceModel().signs[page])
        return true
    }
    
}

