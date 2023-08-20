//
//  ImageCollectionViewCell.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 22.07.2023.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupdefaultVariables()
    }
    
//метод загружающий по юрл картинку и устанавливающий в ячейку картинку
    func setupCell(_ url: String, currentIndexPath: IndexPath) {
        guard let url = URL(string: "https://gallery.prod1.webant.ru/media/\(url)") else {
            return
        }
        print(url)
        photoView.kf.indicatorType = .activity
        photoView.kf.setImage(with: url)
    }
}

extension ImageCollectionViewCell {
    
    func setupdefaultVariables() {
        photoView.layer.cornerRadius = 10

        let radius: CGFloat = 10
        shadowView.layer.cornerRadius = radius
        shadowView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 3.5, height: 3.5)
        shadowView.layer.shadowOpacity = 0.7
        shadowView.layer.shadowRadius = 2.5
        shadowView.layer.masksToBounds = false
    }
}
