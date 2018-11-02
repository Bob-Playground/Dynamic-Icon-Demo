//
//  Awake.swift
//  Dynamic-Icon-Demo
//
//  Created by HuangLibo on 2018/10/29.
//  Copyright © 2018 HuangLibo. All rights reserved.
//

import Foundation

protocol LoadProtocol: class {
    // 实现协议的类在此方法中做 method swizzling
    static func awake()
}

class NothingToSeeHere {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        // 遍历所以的类, 如果实现了 LoadProtocol 协议, 则执行协议中的方法.
        for index in 0 ..< typeCount {
            (types[index] as? LoadProtocol.Type)?.awake()
        }
        types.deallocate()
    }
}
