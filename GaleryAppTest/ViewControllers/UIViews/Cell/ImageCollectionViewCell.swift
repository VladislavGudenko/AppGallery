//
//  ImageCollectionViewCell.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 22.07.2023.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell(_ url: String) {
        guard let url = URL(string: "https://gallery.prod1.webant.ru/media/\(url)") else {return}
        
        print(url)
        photoView.kf.indicatorType = .activity
        photoView.kf.setImage(with: url)
        photoView.clipsToBounds = true
        photoView.layer.cornerRadius = 10
    }
    
}
