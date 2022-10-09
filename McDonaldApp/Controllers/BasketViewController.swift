//
//  CafeViewController.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/04.
//

import UIKit

protocol DropDownEventDelegate {
    func setBasketData(burger: McdonaldModel, data: Int)
}

class BasketViewController: UIViewController {
    
    // MARK: - 변수선언부
    
    @IBOutlet weak var orderButton: UIButton! {
        didSet {
            if orderButton == nil {
                print("닐 이야 ~ 버튼이")
            }
        }
    }
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var basketData: [McdonaldModel]? {
        didSet {
            guard let basketData = basketData else { return }
//            refreshTabBar(num: basketData.count)
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
//        refreshTabBar(num: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDatas()
        updateDatas()
        basketTableView.reloadData()
    }
    
    func setupDatas() {
        let keys = Array(dataManager.getBasketData().keys)
        self.basketData = keys
        let count = dataManager.getBasketDataCounts()
        self.basketCountDatas = count
    }
    
    func updateDatas() {
        totalPrice = dataManager.getTotalPrice()
        let value = totalPrice as NSNumber
        numberFormatter.numberStyle = .decimal
        guard let result = numberFormatter.string(from: value) else { return }
        if orderButton == nil {
            print("오더버튼이 닐이야 ~~")
        }
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
    

}

// MARK: -장바구니 우측 스와이프로 삭제하기
extension BasketViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            guard let selectedBurger = self.basketData?[indexPath.row] else { return }
            self.setBasketData(burger: selectedBurger, data: 0)
            success(true)
            self.setupDatas()
            self.basketTableView.reloadData()
        }
        delete.backgroundColor = .systemRed
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
        cell.delegate = self
        
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
        
        cell.titleLabel.text = item.name
        cell.mainImage.image = item.image
        cell.priceLabel.text = price
        cell.tfInput.text = "\(count)"
        return cell
    }

}

extension BasketViewController: UITabBarControllerDelegate {
    
}

extension BasketViewController: DropDownEventDelegate {

    func setBasketData(burger: McdonaldModel, data: Int) {
        dataManager.setNewBasketData(burger: burger, data: data)
        updateDatas()
    }
    
    
}
