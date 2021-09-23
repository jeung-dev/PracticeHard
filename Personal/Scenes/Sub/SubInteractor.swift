//
//  SubInsteractor.swift
//  Personal
//
//  Created by 으정이 on 2021/09/20.
//

import Foundation

protocol SubBusinessLogic {
    var viewId: VCInfo? { get }
    func fetchCovid19DataFromServer(page p: String,perPage pp: String)
    func kakaoLogin()
}

protocol SubDataStore {
    var viewId: VCInfo? { get set }
    var covidData: [Sub.FetchData.Covid19]? { get set }
}

class SubInteractor: SubBusinessLogic, SubDataStore {
    
    
    
    var presenter: SubPresentationLogic?
    var viewId: VCInfo?
    var covidData: [Sub.FetchData.Covid19]? = []
    var subWorker = SubWorker()
    
    func fetchCovid19DataFromServer(page p: String,perPage pp: String) {
        subWorker.fetchData(page: p, perPage: pp) { result in
            guard result != nil else {
                Logger.d("No result!!!")
                return
            }
            guard let resultDict = result?.dictionary, let data = resultDict["data"] else {
                Logger.d("No data!!!")
                return
            }
            
            for i in 0..<data.count {
                var eachData = Sub.FetchData.Covid19()
                for detaileData in data[i] {
                    let key = detaileData.0
                    let value = detaileData.1
                    
                    switch key {
                    case "id":
                        eachData.id = value.intValue
                        break
                    case "facilityName":
                        eachData.facilityName = value.stringValue
                        break
                    case "address":
                        eachData.address = value.stringValue
                        break
                    case "updatedAt":
                        eachData.updatedAt = value.stringValue
                        break
                    case "createdAt":
                        eachData.createdAt = value.stringValue
                        break
                    case "centerName":
                        eachData.centerName = value.stringValue
                        break
                    case "sido":
                        eachData.sido = value.stringValue
                        break
                    case "sigungu":
                        eachData.sigungu = value.stringValue
                        break
                    case "zipCode":
                        eachData.zipCode = value.stringValue
                        break
                    case "lat":
                        eachData.lat = value.stringValue
                        break
                    case "lng":
                        eachData.lng = value.stringValue
                        break
                    case "centerType":
                        eachData.centerType = value.stringValue
                        break
                    case "org":
                        eachData.org = value.stringValue
                        break
                    case "phoneNumber":
                        eachData.phoneNumber = value.stringValue
                        break
                    default: break
                    }
                }
                
                self.covidData?.append(eachData)
                
            }
            
            self.presenter?.fetchCovidData(covidData: self.covidData!)
            
        }
    }
    
    func kakaoLogin() {
        subWorker.kakaoLogin(completionHandler: { user in
            var subUser = Sub.FetchData.UserInfo()
            subUser.nickname = user?.kakaoAccount?.profile?.nickname
            subUser.profileImageUrl = user?.kakaoAccount?.profile?.profileImageUrl
            subUser.thumbnailImageUrl = user?.kakaoAccount?.profile?.thumbnailImageUrl
            self.presenter?.fetchUserInfo(user: subUser)
        })
    }
}
