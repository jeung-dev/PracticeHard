//
//  MainInteractor.swift
//  Personal
//
//  Created by 으정이 on 2021/09/18.
//

import Foundation

protocol MainBusinessLogic {
    //Interactor의 모든 함수는 이 프로토콜에 선언되고, View Controller에서 Interactor의 모든 함수들을 이용할 수 있다.
    var viewId: VCInfo? { get }
    func fetchViewId(viewId: VCInfo)
}
protocol MainDataStore {
    //현재 상태를 유지해야하는 모든 프로퍼티들은 이 프로토콜에 선언되어야 한다. 이 프로토콜은 주로 Router와 View Controller 사이에 통신하는 데 사용된다.
    var viewId: VCInfo? { get set }
}
class MainInteractor: MainBusinessLogic, MainDataStore {
    var presenter: MainPresentationLogic?
    var viewId: VCInfo?
    
    func fetchViewId(viewId: VCInfo) {
        self.viewId = viewId
    }
}
