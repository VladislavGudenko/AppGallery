//
//  VC+CollectionView.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import UIKit

extension SecondViewControllerImp: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getImages().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard let data = presenter?.getImages() else {
            return UICollectionViewCell()
        }
        cell.setupCell(data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(2)
        let heightCell = widthCell
        let spacing = CGFloat((3)) * 2 / CGFloat(2)
        
        
        return CGSize(width: widthCell - spacing, height: heightCell - (4))
    }
}
