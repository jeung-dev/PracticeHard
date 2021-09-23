//
//  BasicViewController.swift
//  Personal
//
//  Created by 으정이 on 2021/09/09.
//

import Foundation
import UIKit
import SnapKit
open class BaseViewController: UIViewController {
    
    //MARK: Indicator
    private let loadingIndicator: ProgressView = {
        let progress = ProgressView(colors: [.red, .systemGreen, .systemBlue], lineWidth: 5)
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    func startLoadingIndicator() {
        addLoadingIndicator()
        loadingIndicator.isHidden = false
        loadingIndicator.isAnimating = true
    }
    
    func stopLoadingIndicator() {
        loadingIndicator.isAnimating = false
        loadingIndicator.isHidden = true
        removeLoadingIndicator()
    }
    
    func addLoadingIndicator() {
        
        self.view.addSubview(loadingIndicator)
        
        loadingIndicator.snp.makeConstraints { make in
            Logger.i("Indicator: \(self.view.center)")
            make.centerX.equalTo(self.view.center)
            make.centerY.equalTo(self.view.center)
            make.width.equalTo(80)
            make.height.equalTo(loadingIndicator.snp.width)
        }
    }
    
    func removeLoadingIndicator() {
        loadingIndicator.removeFromSuperview()
    }
    
}
