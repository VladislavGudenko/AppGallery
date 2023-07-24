//
//  SecondViewPresenterImp.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import Foundation

class SecondViewPresenterImp: SecondViewPresenter {
    
    private weak var view: SecondViewController?
    private let router: SecondViewRouter
    
    private var images = [String]()
    
    init(_ view: SecondViewController,
         _ router: SecondViewRouter) {
        self.view = view
        self.router = router
    }
    
    func getImages() -> [String] {
        images
    }
    
    func loadImages() {
        for index in 0...9 {
            let image = "dog\(index)"
            images.append(image)
        }
        
        view?.reloadCollectionView()
    }
    
    
}
