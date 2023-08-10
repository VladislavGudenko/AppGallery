//
//  DetailViewController.swift
//  GaleryAppTest
//
//  Created by Владислав Гуденко on 01.08.2023.
//

import UIKit
import Kingfisher
//подписываем также на коллекшн вью (UICollectionViewDelegate)
class DetailViewController: UIViewController, UICollectionViewDelegate {
    
    //создаем ИмеджВью и 4 лэйбла с именем картинки, описанием, именем пользоватея и датой
    let imageView = UIImageView()
    let detailName = UILabel()
    let descriptionView = UILabel()
    let userName = UILabel()
    let dateCreation = UILabel()
    
    
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
        guard let date = dateFormatter.date(from: stringImage) else {
            return ""
        }
        let neededDate = DateFormatter()
        neededDate.dateFormat = "dd.MM.yyyy"
        let dateString = neededDate.string(from: date)
        dateCreation.text = dateString
        return dateString
       
    }

        override func viewDidLoad() {
            super.viewDidLoad()
        //добавляем сабВью для вью
            view.addSubview(imageView)
            view.addSubview(detailName)
            view.addSubview(descriptionView)
            view.addSubview(userName)
            view.addSubview(dateCreation)
        //констрейнты для имеджвью + сглаживание углов и растягивание изображения внутри
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10
            imageView.contentMode = .scaleAspectFill
        //констрейнты для имени картинки
            detailName.translatesAutoresizingMaskIntoConstraints = false
            detailName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50).isActive = true
            detailName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        //констрейнты для имени пользователя
            userName.translatesAutoresizingMaskIntoConstraints = false
            userName.topAnchor.constraint(equalTo: detailName.bottomAnchor, constant: 20).isActive = true
            userName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        //констрейнты для даты загрузки картинки
            dateCreation.translatesAutoresizingMaskIntoConstraints = false
            dateCreation.topAnchor.constraint(equalTo: detailName.bottomAnchor, constant: 20).isActive = true
            dateCreation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        //возможность переноса по словам текста описания картинки а также ее констрейнты
            descriptionView.numberOfLines = 0
            descriptionView.lineBreakMode = .byWordWrapping
            descriptionView.sizeToFit()
            descriptionView.translatesAutoresizingMaskIntoConstraints = false
            descriptionView.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 20).isActive = true
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
            descriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
         //установка цвета шрифтов и вью (также установлены цвета таббара и навигейшена внутри сториборда
            detailName.textColor = .black
            descriptionView.textColor = .black
            userName.textColor = .gray
            dateCreation.textColor = .gray
            view.backgroundColor = .white
        }
    }
