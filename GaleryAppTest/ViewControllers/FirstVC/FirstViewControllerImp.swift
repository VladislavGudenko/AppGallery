//
//  FirstViewControllerImp.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 22.07.2023.
//

import UIKit
import Alamofire
import Kingfisher
//здесь создаем и регистрируем ячейку из отдельного ксибовского файла и показываем картинки из метода лоадИмеджес
class FirstViewControllerImp: UIViewController {
    
    var presenter: FirstViewPresenter?

    let cellId = "cell"
    
    @IBOutlet weak var firstCollection: UICollectionView!
    
    var indicator = UIActivityIndicatorView()
    
    var internetView = UIView()
    var internetImage = UIImageView()
    var internetText = UILabel()
    var isLoading = false
    var arrayDataNew = [Data]()
    var currentPage = 1
    var totalPages: Int?
    
    var getUrl: String {
        "https://gallery.prod1.webant.ru/api/photos?new=true&popular=false&page=\(currentPage)&limit=10"
    }
    
    func setupInternetImage() {
        internetImage.image = UIImage(named: "noInternet")
        internetText.text = "Опять не заплатил за интернет??"
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
                        self.arrayDataNew.append(i!)
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
                    self.firstCollection.reloadData()
                }
        } else {
            internetView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(internetImage)
        view.addSubview(internetText)
        
        internetImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 250).isActive = true
        
        view.addSubview(indicator)
        indicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 100).isActive = true
        
        setupInternetImage()
        
        FirstViewConfigurator.configure(view: self)
        
        firstCollection.dataSource = self
        firstCollection.delegate = self
        firstCollection.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        
        
        
        request()
        
        
//        func request() {
//            if Connectivity.isConnectedToInternet {
//                internetView.isHidden = true
//                guard let url = URL(string: getUrl)
//                else { return }
//                print("url = \(url)")
//                AF.request(url)
//                    .responseDecodable (of: Model.self) { response in
//                        print(response.value?.data.count ?? "error")
//                        guard let data = response.value?.data else { return }
//                        for i in data {
//                            self.arrayDataNew.append(i!)
//                        }
//                        if self.totalPages == nil {
//                            guard let countPages = response.value?.countOfPages else {
//                                print("error count of pages")
//                                return
//                            }
//                            self.totalPages = countPages
//                        }
//                        self.currentPage += 1
//                        print(self.currentPage)
//                        self.firstCollection.reloadData()
//                    }
//            } else {
//                internetView.isHidden = false
//            }
//        }
        
        
        
    }
}


extension FirstViewControllerImp: FirstViewController {
    func reloadCollectionView() {
        firstCollection.reloadData()
    }
}
