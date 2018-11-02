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
        
        if !UIApplication.shared.supportsAlternateIcons {
            return
        }
        
        if segmentedControl.selectedSegmentIndex == 0 {
            // 设置为默认 icon
            UIApplication.shared.setAlternateIconName(nil, completionHandler: nil)
        } else if segmentedControl.selectedSegmentIndex == 1 {
            alternateIconName = "dark-icon"
        } else if segmentedControl.selectedSegmentIndex == 2 {
            alternateIconName = "funny-icon"
        } else if segmentedControl.selectedSegmentIndex == 3 {
            let alertController = UIAlertController(title: "标题 title", message: "信息 message", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true)
        }
        
        if let alternateIconName = alternateIconName {
            UIApplication.shared.setAlternateIconName(alternateIconName, completionHandler: nil)
        }
    }
}

extension UIViewController: LoadProtocol {
    static func awake() {
        UIViewController.classInit()
    }
    static func classInit() {
        swizzleMethod
    }
    
    @objc func swizzled_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if viewControllerToPresent is UIAlertController {
            let alertController = viewControllerToPresent as! UIAlertController
            if alertController.title == nil && alertController.message == nil {
                return
            } else {
                self.swizzled_present(viewControllerToPresent, animated: flag, completion: completion)
                return
            }
        }
        self.swizzled_present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    private static let swizzleMethod: Void = {
        let originalSelector = #selector(present(_:animated:completion:))
        let swizzledSelector = #selector(swizzled_present(_:animated:completion:))
        swizzlingForClass(UIViewController.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }()
    private static func swizzlingForClass(_ cls: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {
        let originalMethod = class_getInstanceMethod(cls, originalSelector)
        let swizzledMethod = class_getInstanceMethod(cls, swizzledSelector)
        guard (originalMethod != nil && swizzledMethod != nil) else {
            return
        }
        if class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!)) {
            class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }
}
