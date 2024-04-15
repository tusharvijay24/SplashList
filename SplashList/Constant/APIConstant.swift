//
//  APIConstant.swift
//  SplashList
//
//  Created by Tushar on 13/04/24.
//

import Foundation

struct APIConstants {
    static let unsplashAPIBaseURL = "https://api.unsplash.com/"
    static let photosEndpoint = "photos"
    
    static var fullSplashUrl: String {
        return unsplashAPIBaseURL + photosEndpoint
    }
}
