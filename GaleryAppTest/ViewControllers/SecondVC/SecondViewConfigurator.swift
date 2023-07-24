//
//  SecondViewConfigurator.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import Foundation

enum SecondViewConfigurator {
    
    static func configure(view: SecondViewControllerImp) {
        let router = SecondViewRouter(view: view)
        let presenter = SecondViewPresenterImp(view, router)
        view.presenter = presenter
    }
}
