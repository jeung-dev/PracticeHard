//
//  SubWorker.swift
//  Personal
//
//  Created by 으정이 on 2021/09/09.
//

import Foundation
import Alamofire
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

public typealias UserDataHandler = (User?) -> Void
class SubWorker {
    
    public init() {
        
    }
    
    private var headers: HTTPHeaders {
        [.contentType("application/x-www-form-urlencoded"),
         .accept("application/json"),
         .authorization("Infuser m+AB97QjVAk8g8IGN9PTm5H+dfLsRRkZVWVXfhPqgvcko5uRCLo7ai4ak/S57jyNOqKLxq7xiDzPRyUqDrQbZw==")]
    }
    
    public func fetchData(page: String, perPage: String, jsonResultHandler: @escaping JSONResultHandler) {
        let const = NetworkAPI.Centers.default
        let params: [String:Any] = ["page":page,
                                    "perPage":perPage,
                                    "returnType":"json"]
        NetworkAPI.shared.request(reqConst: const, params: params, headers: headers, jsonResultHandler: jsonResultHandler)
    }
    
    private func needKakaoLogin() {
        //카카오톡 설치여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if error != nil {
                    Logger.d(error as Any)
                } else {
                    Logger.d("loginWithKakaoTalk() success.")
                    
                    //do something
                    KAKAO_OAUTH_TOKEN = "\(oauthToken!)"
                    Logger.d(KAKAO_OAUTH_TOKEN)
                }
            }
        } else {
            //카카오톡 설치가 안 되어 있으므로 인터넷으로 로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if error != nil {
                    Logger.d(error as Any)
                } else {
                    Logger.d("loginWithKakaoTalk() success.")
                    
                    //do something
                    KAKAO_OAUTH_TOKEN = "\(oauthToken!)"
                    Logger.d(KAKAO_OAUTH_TOKEN)
                    /*
                     OAuthToken(tokenType: "bearer", accessToken: "IHp7xg6ok2cIzQDWesOQ1NOfjYo8o3Z2N8oOYQo9c5oAAAF79OSG5Q", expiresIn: 43199.0, expiredAt: 2021-09-18 05:53:41 +0000, refreshToken: "SE8HZqMf0MJjl1kQC1yj0K4hb5POHdoIFKXsvAo9c5oAAAF79OSG5A", refreshTokenExpiresIn: 5183999.0, refreshTokenExpiredAt: 2021-11-16 17:53:41 +0000, scope: Optional("profile_image profile_nickname"), scopes: Optional(["profile_image", "profile_nickname"]))
                     */
                }
            }
        }
    }
//    completionHandler: @escaping ([Order], OrdersStoreError?) -> Void
    public func kakaoLogin(completionHandler: @escaping UserDataHandler) {
        //토큰 존재 여부 확인
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { _, error in
                
                if error != nil {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true {
                        //로그인 필요
                        self.needKakaoLogin()
                    } else {
                        //기타 에러 -- 문서에 따라 각 처리 필요
                        Logger.d(error as Any)
                    }
                } else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    self.kakaoUserInfo(completionHandler: { user in
                        completionHandler(user)
                    })
                }
            }
        } else {
            //토큰이 존재하지 않으므로 로그인 필요
            needKakaoLogin()
        }
    }
    
    private func kakaoUserInfo(completionHandler: @escaping UserDataHandler) {
        UserApi.shared.me { user, error in
            if error != nil {
                Logger.d(error as Any)
            } else {
                Logger.d("me() success.")
                //do something
                Logger.i(user as Any)
                completionHandler(user)
                /*
                 Optional(KakaoSDKUser.User(id: Optional(1914186121), properties: Optional(["nickname": "정은", "profile_image": "https://k.kakaocdn.net/dn/2tZ6l/btrcb9EBbKL/p5ZYpIvwokNxT21xKL9Yck/img_640x640.jpg", "thumbnail_image": "https://k.kakaocdn.net/dn/2tZ6l/btrcb9EBbKL/p5ZYpIvwokNxT21xKL9Yck/img_110x110.jpg"]), kakaoAccount: Optional(KakaoSDKUser.Account(profileNeedsAgreement: nil, profileNicknameNeedsAgreement: Optional(false), profileImageNeedsAgreement: Optional(false), profile: Optional(KakaoSDKUser.Profile(nickname: Optional("정은"), profileImageUrl: Optional(https://k.kakaocdn.net/dn/2tZ6l/btrcb9EBbKL/p5ZYpIvwokNxT21xKL9Yck/img_640x640.jpg), thumbnailImageUrl: Optional(https://k.kakaocdn.net/dn/2tZ6l/btrcb9EBbKL/p5ZYpIvwokNxT21xKL9Yck/img_110x110.jpg), isDefaultImage: Optional(false))), emailNeedsAgreement: nil, isEmailValid: nil, isEmailVerified: nil, email: nil, ageRangeNeedsAgreement: nil, ageRange: nil, birthyearNeedsAgreement: nil, birthyear: nil, birthdayNeedsAgreement: nil, birthday: nil, birthdayType: nil, genderNeedsAgreement: nil, gender: nil, phoneNumberNeedsAgreement: nil, phoneNumber: nil, ciNeedsAgreement: nil, ci: nil, ciAuthenticatedAt: nil, legalNameNeedsAgreement: nil, legalName: nil, legalBirthDateNeedsAgreement: nil, legalBirthDate: nil, legalGenderNeedsAgreement: nil, legalGender: nil, isKoreanNeedsAgreement: nil, isKorean: nil)), groupUserToken: nil, connectedAt: Optional(2021-09-17 17:48:09 +0000), synchedAt: nil, hasSignedUp: nil))
                 */
                
            }
        }
    }
}
