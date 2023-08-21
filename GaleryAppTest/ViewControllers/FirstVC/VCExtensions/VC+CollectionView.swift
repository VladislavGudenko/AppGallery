//
//  VC+CollectionView.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import UIKit
import Alamofire
import Kingfisher


//MARK: - Extension Collection View
extension FirstViewControllerImp: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //здесь устанавливаем количество элементов в секции - прогоняется через массив.каунт
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getImages().count ?? 0
    }
    //здесь привязываем к ячейке картинку - картинка проходит через массив индекспас и данные берутся из структуры
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let data = presenter?.getImages() else { return UICollectionViewCell() }
        cell.setupCell(data[indexPath.row].image?.name ?? "", currentIndexPath: indexPath)
        print("data is \(data)")
        return cell
    }
    //минимальное расстояние между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let lineSpacing = CGFloat(15)
        return lineSpacing
    }
    //минимальное расстояние между линиями
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let itemSpacing = CGFloat(15)
        return itemSpacing
    }
    //задаем количество и размерность ячеек - экран делится на 2 части и минус2*12(24)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2 - 2 * 12
        if UIApplication.shared.statusBarOrientation.isLandscape {
            let landscapeLeftWidth = collectionView.frame.width / 2 - 2 * 12
            return CGSize(width: landscapeLeftWidth, height: landscapeLeftWidth)
        }
        return CGSize(width: width, height: width)
    }
    //задаем отступы между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if UIApplication.shared.statusBarOrientation.isLandscape {
            return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        }
        return UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    //здесь метод который по нажатию на ячейку передает в детальный вью контроллер - картинку по ее имени, название, описание, имя пользователя и дату
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        guard let images = presenter?.getImages() else {return}
        navigationController?.pushViewController(detailViewController,
                                                 animated: true)
        detailViewController.setupCell(stringImage: images[indexPath.row].image?.name ?? "")
        detailViewController.printName(stringImage: images[indexPath.row].name ?? "")
        detailViewController.printDescription(stringImage: images[indexPath.row].description ?? "")
        detailViewController.printUserName(stringImage: images[indexPath.row].user ?? "")
        detailViewController.printDate(stringImage: images[indexPath.row].dateCreate ?? "")
    }
    //данный метод отвечает за пагинацию - если текущая страница меньше или равно чем общее количество страниц выполняется запрос - в запросе стоит += 1 поэтому к каждой текущей странице прибавляется еще одна и так далее пока не достигнет конца страницы
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let count = presenter?.getImages().count else { return }
        if indexPath.row == count - 1 {
            act.isHidden = false
            guard let totalPages = presenter?.totalPages,
                  presenter?.currentPage ?? 0 <= totalPages
            else {
                act.isHidden = presenter?.currentPage ?? 0 > presenter?.totalPages ?? 0
                return
            }
            presenter?.request()
        }
    }
}
