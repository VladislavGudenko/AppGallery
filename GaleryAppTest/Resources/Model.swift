//
//  Model.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 05.08.2023.
//

import Foundation
import Alamofire
import UIKit

struct Model: Codable {
    var totalItems, itemsPerPage, countOfPages: Int?
    var data: [Data?]
}

struct Data: Codable {
    var name, user, dateCreate, description: String?
    var new, popular: Bool?
    var id: Int?
    var image: Image?
}

struct Image: Codable {
    var id: Int
    var name: String
}
