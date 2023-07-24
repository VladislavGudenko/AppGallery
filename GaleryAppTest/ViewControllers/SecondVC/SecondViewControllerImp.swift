//
//  SecondViewControllerImp.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 22.07.2023.
//

import UIKit

class SecondViewControllerImp: UIViewController {
    
    var presenter: SecondViewPresenter?
    
    let cellId = "cell"
    
    @IBOutlet weak var secondCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SecondViewConfigurator.configure(view: self)
        
        secondCollection.dataSource = self
        secondCollection.delegate = self
        secondCollection.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
        
        presenter?.loadImages()
    }
}

extension SecondViewControllerImp: SecondViewController {
    func reloadCollectionView() {
        secondCollection.reloadData()
    }
}

