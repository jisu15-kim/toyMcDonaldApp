//
//  CafeViewController.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/04.
//

import UIKit

class BasketViewController: UIViewController {
    
    // MARK: - 변수선언부
    
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var basketData: [McdonaldModel]? {
        didSet {
            guard let basketData = basketData else { return }
            refreshTabBar(num: basketData.count)
            emptyTextConditional()
        }
    }
    var basketCountDatas: [Int]?
    var dataManager = DataManager()
    let tabBar = UITabBarItem()
    let numberFormatter = NumberFormatter()
    var totalPrice: Int = 0
    
    @IBOutlet weak var basketTableView: UITableView!
    
    // Empty 출력 레이블
    let emptyLabel: UILabel = {
        let label = UILabel()  //메모리에 올라가는 부분
        label.textColor = .black
        label.textAlignment = .center
        label.text = "텅~ 비었어요🫙"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    // MARK: - 함수구현부
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatas()
        showEmptyText()
        emptyTextConditional()
        setupTabBar()
        setupUI()
        updateDatas()
        setupTableView()
        refreshTabBar(num: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDatas()
        basketTableView.reloadData()
    }
    
    func setupDatas() {
        let keys = Array(dataManager.getBasketData().keys)
        self.basketData = keys

        let count = dataManager.getBasketDataCounts()
        self.basketCountDatas = count
        
        totalPrice = dataManager.getTotalPrice()
    }
    
    func updateDatas() { // 도데체 왜 에러가 날까 ?!
        totalPrice = dataManager.getTotalPrice()
        let value = totalPrice as NSNumber
        numberFormatter.numberStyle = .decimal
        guard let result = numberFormatter.string(from: value) else { return }
        self.totalPriceLabel.text = "\(result)원"
    }
    
    func setupTableView() {
        title = "장바구니"
        basketTableView.delegate = self
        basketTableView.dataSource = self
        basketTableView.rowHeight = 150
    }
    
    func setupTabBar() {
        tabBarController?.delegate = self
    }
    
    func setupUI() {
        orderButton.layer.cornerRadius = 7
    }
    
    func showEmptyText() {
        view.addSubview(emptyLabel)
        self.emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.emptyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.emptyLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func emptyTextConditional() {
        guard let data = basketData else { return }
        if data.count == 0 {
            emptyLabel.text = "텅~ 비었어요🫙"
        } else {
            emptyLabel.text = ""
        }
    }
    
    func refreshTabBar(num: Int) {
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[2]
            tabItem.badgeValue = "\(num)"
            return
        }
    }
    
    func removeButton(burger: McdonaldModel, count: Int = 1) {
        dataManager.removeBasketData(burger: burger, count: count)
        // updateDatas()
        // setupDatas()
        // basketTableView.reloadData()
    }
    
    func addButton(burger: McdonaldModel) {
        dataManager.addToBasket(burger: burger)
        // updateDatas()
    }
    
}

extension BasketViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            guard let selectedBurger = self.basketData?[indexPath.row] else { return }
            guard let selectedBurgerCount = self.basketCountDatas?[indexPath.row] else { return }
            self.removeButton(burger: selectedBurger, count: selectedBurgerCount)
            success(true)
        }
        delete.backgroundColor = .systemRed

        //actions배열 인덱스 0이 왼쪽에 붙어서 나옴
        return UISwipeActionsConfiguration(actions:[delete])
    }
    
}

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = basketData else { return 0 }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = basketTableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketCell
        
        guard let array = basketData else { return cell }
        guard let countArray = basketCountDatas else { return cell }
        let item = array[indexPath.row]
        let count = countArray[indexPath.row]
        cell.item = item
        
        // 콤마찍기
        var price: String {
            let value = item.price as NSNumber
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: value)
            return "\(result!)원"
        }
        
        cell.titleLabel.text = item.burgerName
        cell.mainImage.image = item.burgerImage
        cell.priceLabel.text = price
        cell.countLabel.text = "\(count)"
        cell.countStepper.value = Double(count)
        print(count)
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    //
    //        return "This is table footer"
    //    }
}

extension BasketViewController: UITabBarControllerDelegate {
    
}
