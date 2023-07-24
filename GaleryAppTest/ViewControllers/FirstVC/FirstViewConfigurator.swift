//
//  FirstViewConfigurator.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import Foundation

enum FirstViewConfigurator {
    
    static func configure(view: FirstViewControllerImp) {
        let router = FirstViewRouter(view: view)
        let presenter = FirstViewPresenterImp(view, router)
        view.presenter = presenter
    }
}
