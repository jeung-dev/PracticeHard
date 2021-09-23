//
//  AppConfig.swift
//  Personal
//
//  Created by 으정이 on 2021/09/09.
//

import Foundation

enum AppConfig {
    
    enum Variant {
        case local
        case dev
        case test
        case release
    }
    
    static func getVariant() -> Variant {
        #if DEBUG
        
        return .dev
        #else
        return .release
        #endif
        
    }
}
