//
//  FirstViewControllerImp.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 22.07.2023.
//

import UIKit
import Alamofire
import Kingfisher

class FirstViewControllerImp: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var rotatingImageView: UIImageView!
    @IBOutlet weak var act: UIView!
    @IBOutlet weak var firstCollection: UICollectionView!
    
    //MARK: - Properties
    var presenter: FirstViewPresenter?
    let cellId = "cell"
    var internetImage = UIImageView()
    var internetText = UILabel()
    var myRefreshControl: UIRefreshControl? {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        FirstViewConfigurator.configure(view: self)
        act.isHidden = true
        overrideUserInterfaceStyle = .light
        setupInternetImage()
        setInternetText()
        setInternetImage()
        rotateImageView()
        setCollectionView()
        presenter?.request()
        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    //устанавливаем цвет шрифта в таббаре и скрываем навигейшн контроллер
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        tabBarController?.tabBar.isHidden = false
        tabBarController?.tabBar.tintColor = UIColor(red: 0.81, green: 0.29, blue: 0.49, alpha: 1)
        tabBarController?.tabBar.unselectedItemTintColor = UIColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    //MARK: - Methods
    @objc func orientationDidChange() {
        self.firstCollection.reloadData()
    }
    
    func setInternetImage () {
        view.addSubview(internetImage)
        internetImage.translatesAutoresizingMaskIntoConstraints = false
        internetImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
        internetImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        internetImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        internetImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        internetImage.clipsToBounds = true
        internetImage.layer.cornerRadius = 10
        internetImage.contentMode = .scaleAspectFit
    }
    
    func setInternetText () {
        view.addSubview(internetText)
        internetText.translatesAutoresizingMaskIntoConstraints = false
        internetText.heightAnchor.constraint(equalToConstant: 200).isActive = true
        internetText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
        internetText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        internetText.textColor = .black
    }
    
    func setupInternetImage() {
        internetImage.image = UIImage(named: "noInternet")
        internetText.text = "Опять не заплатил за интернет??"
    }
    
    func rotateImageView() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0
        rotationAnimation.toValue = CGFloat.pi * 2
        rotationAnimation.duration = 2 // Продолжительность анимации в секундах
        rotationAnimation.repeatCount = .infinity // Значение .infinity означает бесконечное повторение
        rotatingImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func setCollectionView () {
        firstCollection.backgroundColor = .white
        firstCollection.refreshControl = myRefreshControl
        firstCollection.dataSource = self
        firstCollection.delegate = self
        firstCollection.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        presenter?.refresh()
        sender.endRefreshing()
    }
}
// MARK: - Extension
extension FirstViewControllerImp: FirstViewController {
    func reloadCollectionView() {
        myRefreshControl?.endRefreshing()
        firstCollection.reloadData()
        self.act.isHidden = true
    }
    
    func setInternetImage(isHidden: Bool) {
        internetImage.isHidden = isHidden
        internetText.isHidden = isHidden
    }
    
    func getSelectedIndex() -> Int {
        tabBarController?.selectedIndex ?? 0
    }
}
