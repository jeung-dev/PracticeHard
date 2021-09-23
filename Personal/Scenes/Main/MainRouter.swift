//
//  MainRouter.swift
//  Personal
//
//  Created by 으정이 on 2021/09/18.
//

import UIKit

@objc protocol MainRoutingLogic {
    //라우팅에 사용되는 모든 함수는 해당 프로토콜에 선언되어 있다.
    func routeToSub(segue: UIStoryboardSegue?)
}

protocol MainDataPassing {
    //목표 View Controller로 전달해야하는 data를 가지고 있는 프로토콜이다.
    var viewId: MainDataStore? { get }
}

class MainRouter: NSObject, MainRoutingLogic, MainDataPassing {
    
    weak var viewController: MainViewController?
    var viewId: MainDataStore?
    
    //MARK: Routing
    func routeToSub(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! SubViewController
            var destinationDS = destinationVC.router!.viewId!
            passDataToSub(source: viewId!, destination: &destinationDS)
        } else {
            let index = viewController!.navigationController!.viewControllers.count - 2
            let destinationVC = viewController?.navigationController?.viewControllers[index] as! SubViewController
            var destinationDS = destinationVC.router!.viewId!
            passDataToSub(source: viewId!, destination: &destinationDS)
            navigateToSub(source: viewController!, destination: destinationVC)
        }
    }
    
    //MARK: Navigation
    func navigateToSub(source: MainViewController, destination: SubViewController) {
        source.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Passing Data
    func passDataToSub(source: MainDataStore, destination: inout SubDataStore) {
        destination.viewId = source.viewId
    }
    
}
