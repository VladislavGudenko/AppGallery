//
//  FirstViewPresenter.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import Foundation

protocol FirstViewPresenter {
    var currentPage: Int {get set}
    var totalPages: Int? {get set}
    func getImages() -> [Data]
    func request()
    func refresh()
}
