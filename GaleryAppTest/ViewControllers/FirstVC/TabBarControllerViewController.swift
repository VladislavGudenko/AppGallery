//
//  TabBarControllerViewController.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 20.08.2023.
//

import UIKit

class TabBarControllerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    private func setupTabBar() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyboard.instantiateViewController(withIdentifier: "FirstViewControllerImp") as! FirstViewControllerImp
        let secondStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let popularViewController = secondStoryboard.instantiateViewController(withIdentifier: "FirstViewControllerImp") as! FirstViewControllerImp
        let first = UINavigationController(rootViewController: newViewController)
        first.tabBarItem = UITabBarItem(title: "New", image: nil, selectedImage: nil)
        let second = UINavigationController(rootViewController: popularViewController)
        second.tabBarItem = UITabBarItem(title: "Popular", image: nil, selectedImage: nil)
        viewControllers = [first, second]
    }
}
