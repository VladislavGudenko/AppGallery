//
//  FirstViewPresenterImp.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import Foundation
import Alamofire
import Kingfisher
//здесь у нас лежат в массиве все наши картинки и досутп к ним обеспечивается через presenter?.getImages()
class FirstViewPresenterImp: FirstViewPresenter {
    func request() {
        
    }
    
    
    
    
    private weak var view: FirstViewController?
    private let router: FirstViewRouter
    
    


    
    private var images = [String]()
    
    init(_ view: FirstViewController,
         _ router: FirstViewRouter) {
        self.view = view
        self.router = router
    }
    
//    func getImages() -> [String] {
//        images
//    }
//
//
//
//    func loadImages() {
//        view?.reloadCollectionView()
//    }
//    
    
    
    
}
