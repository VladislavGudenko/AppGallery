//
//  DetailViewController.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 01.08.2023.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, UICollectionViewDelegate {
    
    //создаем ИмеджВью
    let imageView = UIImageView()
    let detailName = UILabel()
    let descriptionView = UILabel()
    let userName = UILabel()
    let dateCreation = UILabel()
    var name: String?
    var info: String?
    
    func setupCell (stringImage: String) {
        guard let url = URL(string: "https://gallery.prod1.webant.ru/media/\(stringImage)") else {return}
        
        print(url)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: url)
        //делается все через кингфишер
    }
    // здесь все методы показа имени картинки, ее описания, имени пользователя и даты - но имя пользователя и дата выгружаюся в стрранном формате
    func printName (stringImage: String) {
        detailName.text = stringImage
        
    }    
    
    func printDescription (stringImage: String) {
        descriptionView.text = stringImage
    }
    
    func printUserName (stringImage: String) {
        userName.text = stringImage
        print(userName)
    }
    
    func printDate (stringImage: String) {
        dateCreation.text = stringImage
    }
    
    
    
    
    
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
        //добавляем сабВью для вью
            view.addSubview(imageView)
            view.addSubview(detailName)
            view.addSubview(descriptionView)
            view.addSubview(userName)
            view.addSubview(dateCreation)
            
            
            
            detailName.translatesAutoresizingMaskIntoConstraints = false
            detailName.heightAnchor.constraint(equalToConstant: 200).isActive = true
            detailName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250).isActive = true
            detailName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            
            descriptionView.translatesAutoresizingMaskIntoConstraints = false
            descriptionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            descriptionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 350).isActive = true
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            
            descriptionView.numberOfLines = 0
            descriptionView.lineBreakMode = .byWordWrapping
            
            userName.translatesAutoresizingMaskIntoConstraints = false
            userName.heightAnchor.constraint(equalToConstant: 200).isActive = true
            userName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
            userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            
            dateCreation.translatesAutoresizingMaskIntoConstraints = false
            dateCreation.heightAnchor.constraint(equalToConstant: 200).isActive = true
            dateCreation.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
            dateCreation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            
            detailName.textColor = .black
            descriptionView.textColor = .black
            userName.textColor = .gray
            dateCreation.textColor = .gray
        
            
            
            //убираем авторесайзинг
            imageView.translatesAutoresizingMaskIntoConstraints = false
            //задаем все констрейнты для имеджвью
            imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            //здесь констрейнт для сэйф ареа а не от края экрана
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            
            
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            //добавляем возможность закруглить края рамки картинки
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10
            
            //
            imageView.contentMode = .scaleAspectFill
            
            
            
            
            
            
            view.backgroundColor = .white
            
        }
        
        
        
        
        
        
    }

