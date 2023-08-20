////
////  SecondViewControllerImp.swift
////  GaleryAppTest
////
////  Created by Владислав Гуденко on 22.07.2023.
////
//
//import UIKit
//import Alamofire
//import Kingfisher
//
//class SecondViewControllerImp: UIViewController {
//    
//    @IBOutlet weak var customActiviyIndicatorView: UIView!
//    @IBOutlet weak var activityIndicatorImageView: UIImageView!
//    
//    var countOfRequests = 0
//    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        self.secondCollection.reloadData()
//        
////        coordinator.animate(alongsideTransition: { (context) in
////
////        }) { (context) in
////            self.firstCollection.reloadData()
////
////        }
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: false)
//        tabBarController?.tabBar.isHidden = false
//        tabBarController?.tabBar.tintColor = UIColor(red: 0.81, green: 0.29, blue: 0.49, alpha: 1)
//        tabBarController?.tabBar.unselectedItemTintColor = UIColor(red: 0.74, green: 0.74, blue: 0.74, alpha: 1)
//    }
//    //создаем презентер для связи контроллера и презентера
//    var presenter: SecondViewPresenter?
//    //создаем переменную с названием ячейки "cell"
//    let cellId = "cell"
//    //CollectionView была создана в сториборде - привязали аутлет
//    @IBOutlet weak var secondCollection: UICollectionView!
//    //создаем ИмэйджВью для картинки которая будет показывать что нет интернета - туда же добавляем текст, создаем массив который берет данные из структуры Дата
//    //создаем текущую страницу присваиваем ей значение 1, создаем общее количство страниц - количество их мы не знаем - поэтому опциональный интеджер, также создаем гетЮрл который имеет стринговый юрл где текущая страница - "1"
//    var internetImage = UIImageView()
//    var indicator = UIActivityIndicatorView()
//    var internetText = UILabel()
//    var arrayDataPopular = [Data]()
//    var currentPage = 1
//    var totalPages: Int?
//    var getUrl: String {
//        "https://gallery.prod1.webant.ru/api/photos?new=false&popular=true&page=\(currentPage)&limit=10"
//    }
//    //здесь метод для установки картинки и текста в случае отсутствия интернета
//    func setupInternetImage() {
//        internetImage.image = UIImage(named: "noInternet")
//        internetText.text = "Думаешь если переключиться на другой экран\n - интернет появится?"
//    }
//    
//    var canWeMakeNewReques = true
//
//    //здесь метод запроса данных с ЮРЛ, где если интернет есть - то картинка и текст об отсутствии интернета скрыты, далее юрл мы получаем из стрингового который создали ранее и выводим в консоль юрл = "название юрл", далее идет запрос через аламофаер, данные для запроса берутся из структуры (Модэл) и затем прогоняются по массиву - также выводятся данные в консоль об ошибках если например количество страниц отсутствует, также прибавляет по странице на которой 10 шт картинок и обновляет данные коллекшнВью, в случае отсутствия интернета делает видимыми картинку и текст об отсутсвиие интернета
//    func request() {
//        setActivityIndicator(isHidden: false)
//        if !canWeMakeNewReques {
//            print("our request has been cancelled2")
//            return
//        }
//        if Connectivity.isConnectedToInternet {
//            internetImage.isHidden = true
//            internetText.isHidden = true
//            guard let url = URL(string: getUrl)
//            else { return }
//            print("url = \(url)")
//            canWeMakeNewReques = false
//            AF.request(url)
//                .responseDecodable (of: Model.self) { response in
//                    self.canWeMakeNewReques = true
//                    self.setActivityIndicator(isHidden: true)
//                    print(response.value?.data.count ?? "error")
//                    guard let data = response.value?.data else { return }
//                    for i in data {
//                        self.arrayDataPopular.append(i!)
//                    }
//                    if self.totalPages == nil {
//                        guard let countPages = response.value?.countOfPages else {
//                            print("error count of pages")
//                            return
//                        }
//                        self.totalPages = countPages
//                    }
//                    self.currentPage += 1
//                    print(self.currentPage)
//                    self.secondCollection.reloadData()
//                }
//        } else {
//            internetImage.isHidden = false
//            internetText.isHidden = false
//        }
//    }
//    // здесь обновление страницы и подключение к данному методу РефрешКонтрола - метод возвращает в юрл текущую страницу "1" делает заново запрос, обновляет данные коллекции и прекращает вращение рефреш контрола
//    var myRefreshControl: UIRefreshControl? {
//        let refreshControl = UIRefreshControl()
//        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
//        return refreshControl
//    }
//    @objc private func refresh (sender: UIRefreshControl) {
//        currentPage = 1
//        request()
//        arrayDataPopular = []
//        secondCollection.reloadData()
//        sender.endRefreshing()
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //делаем бэкграунд белым и устанавливаем сабвью для интернет имедж и текста
//        view.backgroundColor = .white
//        view.addSubview(internetImage)
//        view.addSubview(internetText)
//        self.overrideUserInterfaceStyle = .light
//
//        rotateImageView()
//        
//        secondCollection.backgroundColor = .white
//        
//        // TODO: - snapKit // займусь решением этого вопроса - ну тут констрейнты
//        internetImage.translatesAutoresizingMaskIntoConstraints = false
//        internetImage.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        internetImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
//        internetImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        internetImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
//        internetImage.clipsToBounds = true
//        internetImage.layer.cornerRadius = 10
//        internetImage.contentMode = .scaleAspectFit
//    //тут для текста
//        internetText.translatesAutoresizingMaskIntoConstraints = false
//        internetText.heightAnchor.constraint(equalToConstant: 200).isActive = true
//        internetText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300).isActive = true
//        internetText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//        internetText.textColor = .black
//        internetText.numberOfLines = 0
//     //метод для установки интернет имеджа
//        setupInternetImage()
//        
//        secondCollection.refreshControl = myRefreshControl
//        
//        SecondViewConfigurator.configure(view: self)
//    //датасоурс и делегат для коллекции - прописываем всегда - а также регистрация ячейки которая была создана отдельно через ксиб файл
//        secondCollection.dataSource = self
//        secondCollection.delegate = self
//        secondCollection.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellId)
//        
//        view.addSubview(indicator)
//        indicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 100).isActive = true
//     //выполнение метода загрузки
//        request()
//    }
//    
//    func rotateImageView() {
//        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
//        rotationAnimation.fromValue = 0
//        rotationAnimation.toValue = CGFloat.pi * 2
//        rotationAnimation.duration = 2 // Продолжительность анимации в секундах
//        rotationAnimation.repeatCount = .infinity // Значение .infinity означает бесконечное повторение
//        
//        activityIndicatorImageView.layer.add(rotationAnimation,
//                                             forKey: "rotationAnimation")
//    }
//    
//    func setActivityIndicator(isHidden: Bool) {
//        customActiviyIndicatorView.isHidden = isHidden
//    }
//}
//
//extension SecondViewControllerImp: SecondViewController {
//    func reloadCollectionView() {
//        secondCollection.reloadData()
//    }
//}
//
