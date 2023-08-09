//
//  SecondViewControllerImp.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 22.07.2023.
//

import UIKit
import Alamofire
import Kingfisher

class SecondViewControllerImp: UIViewController {
    
    var presenter: SecondViewPresenter?
    
    let cellId = "cell"
    
    @IBOutlet weak var secondCollection: UICollectionView!
    
    var indicator = UIActivityIndicatorView()
    
    var internetView = UIView()
    
    var arrayDataPopular = [Data]()
    var currentPage = 1
    var totalPages: Int?
    var getUrl: String {
        "https://gallery.prod1.webant.ru/api/photos?new=false&popular=true&page=\(currentPage)&limit=10"
    }
    
    func request() {
        if Connectivity.isConnectedToInternet {
            internetView.isHidden = true
            guard let url = URL(string: getUrl)
            else { return }
            print("url = \(url)")
            AF.request(url)
                .responseDecodable (of: Model.self) { response in
                    print(response.value?.data.count ?? "error")
                    guard let data = response.value?.data else { return }
                    for i in data {
                        self.arrayDataPopular.append(i!)
                    }
                    if self.totalPages == nil {
                        guard let countPages = response.value?.countOfPages else {
                            print("error count of pages")
                            return
                        }
                        self.totalPages = countPages
                    }
                    self.currentPage += 1
                    print(self.currentPage)
                    self.secondCollection.reloadData()
                }
        } else {
            internetView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SecondViewConfigurator.configure(view: self)
        
        secondCollection.dataSource = self
        secondCollection.delegate = self
        secondCollection.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        view.addSubview(indicator)
        indicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 100).isActive = true
        
        request()
        
        
    }
}

extension SecondViewControllerImp: SecondViewController {
    func reloadCollectionView() {
        secondCollection.reloadData()
    }
}

