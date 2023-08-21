//
//  FirstViewPresenterImp.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import Foundation
import Alamofire
import Kingfisher

class FirstViewPresenterImp: FirstViewPresenter {
    
    //MARK: - Properties
    var arrayDataNew = [Data]()
    var currentPage = 1
    var totalPages: Int?
    var canWeMakeNewReques = true
    var getUrlNew: String {
        "https://gallery.prod1.webant.ru/api/photos?new=true&popular=false&page=\(currentPage)&limit=10"
    }
    var getUrlPopular: String {
        "https://gallery.prod1.webant.ru/api/photos?new=false&popular=true&page=\(currentPage)&limit=10"
    }
    
    var selectedIndex = 0
    
    private weak var view: FirstViewController?
    private let router: FirstViewRouter
    private var images = [String]()
    
    init(_ view: FirstViewController,
         _ router: FirstViewRouter) {
        self.view = view
        self.router = router
    }
    //MARK: - Methods
    func refresh() {
        currentPage = 1
        arrayDataNew = []
        request()
    }
    
    func request() {
        if !canWeMakeNewReques {
            print("our request has been cancelled")
            return
        }
        if Connectivity.isConnectedToInternet {
            view?.setInternetImage(isHidden: true)
            guard let url = URL(string: (self.view?.getSelectedIndex() == 0) ? getUrlNew : getUrlPopular)
            else { return }
            print("url = \(url)")
            canWeMakeNewReques = false
            AF.request(url)
                .responseDecodable (of: Model.self) { [weak self] response in
                    self?.canWeMakeNewReques = true
                    print(response.value?.data.count ?? "error")
                    guard let data = response.value?.data else { return }
                    for i in data {
                        self?.arrayDataNew.append(i!)
                    }
                    if self?.totalPages == nil {
                        guard let countPages = response.value?.countOfPages else {
                            print("error count of pages")
                            return
                        }
                        self?.totalPages = countPages
                    }
                    self?.currentPage += 1
                    print(self?.currentPage)
                    self?.view?.reloadCollectionView()
                }
        } else {
            view?.setInternetImage(isHidden: false)
        }
    }
    func getImages() -> [Data] {
        arrayDataNew
    }
}
