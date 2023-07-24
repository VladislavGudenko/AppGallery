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
        photoView.image = UIImage(named: url)
    }
}
