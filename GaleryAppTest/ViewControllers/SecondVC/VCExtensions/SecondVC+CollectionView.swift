//
//  VC+CollectionView.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import UIKit
import Alamofire
import Kingfisher

extension SecondViewControllerImp: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayDataPopular.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let data = arrayDataPopular
        cell.setupCell(data[indexPath.row].image?.name ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(2)
        let heightCell = widthCell
        let spacing = CGFloat((3)) * 2 / CGFloat(2)
        
        
        return CGSize(width: widthCell - spacing, height: heightCell - (4))
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            let detailViewController = DetailViewController()
                
            let images = arrayDataPopular
        
             
                navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.setupCell(stringImage: images[indexPath.row].image?.name ?? "")
        detailViewController.printName(stringImage: images[indexPath.row].name ?? "")
        detailViewController.printDescription(stringImage: images[indexPath.row].description ?? "")
        detailViewController.printUserName(stringImage: images[indexPath.row].user ?? "")
        detailViewController.printDate(stringImage: images[indexPath.row].dateCreate ?? "")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.arrayDataPopular.count - 1 {
            guard let totalPages = totalPages,
                  currentPage <= totalPages
            else {
                indicator.stopAnimating()
                indicator.hidesWhenStopped = true
                return
            }
            print(currentPage, totalPages, "OLO rabotaet?")
            request()
        }
    }
}
