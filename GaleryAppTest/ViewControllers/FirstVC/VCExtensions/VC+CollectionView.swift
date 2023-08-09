//
//  VC+CollectionView.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import UIKit
import Alamofire
import Kingfisher


//расширения с чем работаем
extension FirstViewControllerImp: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayDataNew.count
    }
    //устанавливаем в ячейку наши картинки из массива гетИмеджес
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let data = arrayDataNew
        cell.setupCell(data[indexPath.row].image?.name ?? "")
        return cell
    }
    //задаем параметры коллекшнвью, расстояния между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(2)
        let heightCell = widthCell
        let spacing = CGFloat((3)) * 2 / CGFloat(2)
        return CGSize(width: widthCell - spacing, height: heightCell - (4))
    }
    

    
    //по нажатию на ячейку осуществляется переход на детальный вьюконтроллер, берем картинки из имени обращаясь к структуре массива images = arrayDataNew - также берем оттуда название, описание, дату, и имя пользователя который выложил картинку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let detailViewController = DetailViewController()
        
        
            
        let images = arrayDataNew
        
            navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.setupCell(stringImage: images[indexPath.row].image?.name ?? "")
        detailViewController.printName(stringImage: images[indexPath.row].name ?? "")
        detailViewController.printDescription(stringImage: images[indexPath.row].description ?? "")
        detailViewController.printUserName(stringImage: images[indexPath.row].user ?? "")
        detailViewController.printDate(stringImage: images[indexPath.row].dateCreate ?? "")

       
        print(images.count)
        
    }
    
    
    // пагинация
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.arrayDataNew.count - 1 {
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
    
    
//    func loadMoreData () {
//        if !self.isLoading {
//            self.isLoading = true
//            DispatchQueue.global().asyncAfter(deadline: .now() + .seconds(1)) {
//                DispatchQueue.main.async {
//                    self.firstCollection.reloadData()
//                    self.isLoading = false
//                }
//            }
//        }
//    }
    
    
}
