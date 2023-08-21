//
//  DetailViewController.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 01.08.2023.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, UICollectionViewDelegate {
    
    //MARK: - Properties
    private lazy var scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.frame = imageView.frame
        scrollView.contentSize = contentSize
        return scrollView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: imageView.frame.width, height: imageView.frame.height)
    }
    
    //создаем ИмеджВью и 4 лэйбла с именем картинки, описанием, именем пользоватея и датой
    let imageView = UIImageView()
    let detailName = UILabel()
    let descriptionView = UILabel()
    let userName = UILabel()
    let dateCreation = UILabel()
    
    //MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    //метод загрузки детального изображения
    func setupCell (stringImage: String) {
        guard let url = URL(string: "https://gallery.prod1.webant.ru/media/\(stringImage)") else {return}
        
        print(url)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
        //делается все через кингфишер
    }
    //метод вывода названия картинки
    func printName (stringImage: String) {
        detailName.text = stringImage
        
    }    
    //метод вывода описания
    func printDescription (stringImage: String) {
        descriptionView.text = stringImage
    }
    //метод вывода имени пользователя
    func printUserName (stringImage: String) {
        userName.text = stringImage
        print(userName)
    }
    //метод вывода даты на детальный экран и изменение формата даты из длинного в коротное
    func printDate (stringImage: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: stringImage) else { return "" }
        let neededDate = DateFormatter()
        neededDate.dateFormat = "dd.MM.yyyy"
        let dateString = neededDate.string(from: date)
        dateCreation.text = dateString
        view.addSubview(dateCreation)
        dateCreation.font = UIFont.systemFont(ofSize: 12)
        dateCreation.translatesAutoresizingMaskIntoConstraints = false
        dateCreation.topAnchor.constraint(equalTo: detailName.bottomAnchor, constant: 4).isActive = true
        dateCreation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        dateCreation.textColor = .gray
        return dateString
    }
    
    func setImage() {
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 0
        imageView.contentMode = .scaleAspectFill
    }
    
    func setDetailName() {
        view.addSubview(detailName)
        detailName.font = UIFont.systemFont(ofSize: 22)
        detailName.translatesAutoresizingMaskIntoConstraints = false
        detailName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        detailName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        detailName.textColor = .black
    }
    
    func setUserName() {
        view.addSubview(userName)
        userName.font = UIFont.systemFont(ofSize: 16)
        userName.translatesAutoresizingMaskIntoConstraints = false
        userName.topAnchor.constraint(equalTo: detailName.bottomAnchor, constant: 4).isActive = true
        userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        userName.textColor = .gray
    }
    
    func setDateCreation() {
        
    }
    
    func setDescriptionView() {
        view.addSubview(descriptionView)
        descriptionView.font = UIFont.systemFont(ofSize: 16)
        descriptionView.numberOfLines = 0
        descriptionView.lineBreakMode = .byWordWrapping
        descriptionView.sizeToFit()
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 14).isActive = true
        descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        descriptionView.textColor = .black
    }
// MARK: - Lifecycle
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setImage()
            setDetailName()
            setUserName()
            setDateCreation()
            setDescriptionView()
        
            view.backgroundColor = .white
            view.addSubview(scrollView)
        }
    }
