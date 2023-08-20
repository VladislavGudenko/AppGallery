//
//  FirstViewController.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 24.07.2023.
//

import Foundation

protocol FirstViewController: AnyObject {
    func reloadCollectionView()
    func setInternetImage(isHidden: Bool)
    func getSelectedIndex() -> Int

}
