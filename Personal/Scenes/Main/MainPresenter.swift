//
//  MainPresenter.swift
//  Personal
//
//  Created by 으정이 on 2021/09/18.
//

import Foundation

protocol MainPresentationLogic {
    //해당 프로토콜에서는 View Controller에서 선언된 delegate 메서드를 호출하며, 이를 통해 ViewModel를 전송한다.
}

class MainPresenter: MainPresentationLogic {
    weak var viewController: MainDisplayLogic?
}
