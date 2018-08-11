//
//  NothingToSeeHere.swift
//  DduGloTaskSwift
//
//  Created by 沈士新 on 2017/12/27.
//  Copyright © 2017年 Danny. All rights reserved.
//

import UIKit
protocol SelfAware: class {
    static func awake()
}

class NothingToSeeHere: NSObject {
    static func harmlessFunction() {
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass>.allocate(capacity: typeCount)
        let autoreleasingTypes = AutoreleasingUnsafeMutablePointer<AnyClass>(types)
        objc_getClassList(autoreleasingTypes, Int32(typeCount))
        for index in 0 ..< typeCount {
            (types[index] as? SelfAware.Type)?.awake()
        }
        types.deallocate(capacity: typeCount)
    }
}
