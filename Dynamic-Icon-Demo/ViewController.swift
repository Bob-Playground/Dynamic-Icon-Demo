//
//  ViewController.swift
//  Dynamic-Icon-Demo
//
//  Created by HuangLibo on 2018/10/26.
//  Copyright © 2018 HuangLibo. All rights reserved.
//

import UIKit

//enum IconType {
//    case primary
//    case dark
//    case funny
//}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func segmentedControlClick(_ segmentedControl: UISegmentedControl) {
        var alternateIconName: String?
        
        if segmentedControl.selectedSegmentIndex == 0 {
            // 设置为默认 icon
            UIApplication.shared.setAlternateIconName(nil, completionHandler: nil)
        } else if segmentedControl.selectedSegmentIndex == 1 {
            alternateIconName = "dark-icon"
        } else if segmentedControl.selectedSegmentIndex == 2 {
            alternateIconName = "funny-icon"
        }
        
        if let alternateIconName = alternateIconName {
            UIApplication.shared.setAlternateIconName(alternateIconName, completionHandler: nil)
        }
    }
}

