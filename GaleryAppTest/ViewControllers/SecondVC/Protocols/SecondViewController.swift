//
//  SecondViewController.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import Foundation

protocol SecondViewController: AnyObject {
    func reloadCollectionView()
    func setActivityIndicator(isHidden: Bool)
}
