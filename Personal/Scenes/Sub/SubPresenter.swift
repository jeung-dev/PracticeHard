//
//  SubPresenter.swift
//  Personal
//
//  Created by 으정이 on 2021/09/20.
//

import Foundation

protocol SubPresentationLogic {
    func fetchCovidData(covidData cd: [Sub.FetchData.Covid19])
    func fetchUserInfo(user: Sub.FetchData.UserInfo)
}

class SubPresenter: SubPresentationLogic {
    
    
    
    weak var viewController: SubDisplayLogic?
    
    func fetchCovidData(covidData cd: [Sub.FetchData.Covid19]) {
        viewController?.displayFetchedCovidData(data: cd)
    }
    func fetchUserInfo(user: Sub.FetchData.UserInfo) {
        viewController?.displayUserInfo(user: user)
    }
}
