//
//  InternetConnection.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 05.08.2023.
//

import Foundation
import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet: Bool {
        return self.sharedInstance.isReachable
    }
}
