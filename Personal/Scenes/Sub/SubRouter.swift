//
//  SubRouter.swift
//  Personal
//
//  Created by 으정이 on 2021/09/20.
//

import UIKit


protocol SubRoutingLogic {
    
}
protocol SubDataPassing {
    var viewId: SubDataStore? { get }
}

class SubRouter: NSObject, SubRoutingLogic, SubDataPassing {
    weak var viewController: SubViewController?
    var viewId: SubDataStore?
}
