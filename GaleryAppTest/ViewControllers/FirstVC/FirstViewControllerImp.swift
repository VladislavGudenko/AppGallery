//
//  FirstViewControllerImp.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 22.07.2023.
//

import UIKit

class FirstViewControllerImp: UIViewController {
    
    var presenter: FirstViewPresenter?

    let cellId = "cell"
    
    @IBOutlet weak var firstCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FirstViewConfigurator.configure(view: self)
        
        firstCollection.dataSource = self
        firstCollection.delegate = self
        firstCollection.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        presenter?.loadImages()
    }
}

extension FirstViewControllerImp: FirstViewController {
    func reloadCollectionView() {
        firstCollection.reloadData()
    }
}
