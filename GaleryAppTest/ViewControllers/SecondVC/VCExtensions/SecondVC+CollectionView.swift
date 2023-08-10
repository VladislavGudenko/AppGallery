//
//  VC+CollectionView.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import UIKit
import Alamofire
import Kingfisher

//все экстеншены для коллекшн вью
extension SecondViewControllerImp: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //здесь устанавливаем количество элементов в секции - прогоняется через массив.каунт
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayDataPopular.count
    }
    //здесь привязываем к ячейке картинку - картинка проходит через массив индекспас и данные берутся из структуры
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        let data = arrayDataPopular
        cell.setupCell(data[indexPath.row].image?.name ?? "")
        return cell
    }
    //здесь мы устанавливаем параметры коллекшнвью (лэйауты) частично сделанные в сториборде и добавленные здесь
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let frameCV = collectionView.frame
        let widthCell = frameCV.width / CGFloat(2)
        let heightCell = widthCell
        let spacing = CGFloat((3)) * 2 / CGFloat(2)
        return CGSize(width: widthCell - spacing, height: heightCell - (4))
    }
    //здесь метод который по нажатию на ячейку передает в детальный вью контроллер - картинку по ее имени, название, описание, имя пользователя и дату
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
    //данный метод отвечает за пагинацию - если текущая страница меньше или равно чем общее количество страниц выполняется запрос - в запросе стоит += 1 поэтому к каждой текущей странице прибавляется еще одна и так далее пока не достигнет конца страницы
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.arrayDataPopular.count - 1 {
            guard let totalPages = totalPages,
                  currentPage <= totalPages
            else {
                indicator.stopAnimating()
                indicator.hidesWhenStopped = true
                return
            }
            request()
        }
    }
}
