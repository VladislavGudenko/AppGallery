//
//  FirstViewPresenterImp.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import Foundation

class FirstViewPresenterImp: FirstViewPresenter {
    
    private weak var view: FirstViewController?
    private let router: FirstViewRouter
    
    private var images = [String]()
    
    init(_ view: FirstViewController,
         _ router: FirstViewRouter) {
        self.view = view
        self.router = router
    }
    
    func getImages() -> [String] {
        images
    }
    
    func loadImages() {
        for index in 0...9 {
            let image = "image\(index)"
            images.append(image)
        }
        view?.reloadCollectionView()
    }
    
    
}
