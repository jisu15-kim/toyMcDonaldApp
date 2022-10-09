//
//  CafeViewController.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/04.
//

import UIKit

protocol StepButtonTypeDelegate {
    func countStepperUp(burger: McdonaldModel)
    func countStepperDown(burger: McdonaldModel, count: Int)
}

final class BasketViewController: UIViewController {
    
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
            refreshTabBar(num: basketData.count)
            emptyTextConditional()
        }
    }
    var basketCountDatas: [Int]? {
        didSet {
            basketTableView.reloadData()
        }
    }
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
    
    private func setupDatas() {
        let keys = Array(dataManager.getBasketData().keys)
        self.basketData = keys

        let count = dataManager.getBasketDataCounts()
        self.basketCountDatas = count
        
        totalPrice = dataManager.getTotalPrice()
    }
    
    // 합계금액 업데이트
    private func updateDatas() {
        totalPrice = dataManager.getTotalPrice()
        let value = totalPrice as NSNumber
        numberFormatter.numberStyle = .decimal
        guard let result = numberFormatter.string(from: value) else { return }
        if orderButton == nil {
            print("오더버튼이 닐이야 ~~")
        }
        self.totalPriceLabel.text = "\(result)원"
    }
    
    private func setupTableView() {
        title = "장바구니"
        basketTableView.delegate = self
        basketTableView.dataSource = self
        basketTableView.rowHeight = 150
    }
    
    private func setupTabBar() {
        tabBarController?.delegate = self
    }
    
    private func setupUI() {
        orderButton.layer.cornerRadius = 7
    }
    
    private func showEmptyText() {
        view.addSubview(emptyLabel)
        self.emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        self.emptyLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.emptyLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    private func emptyTextConditional() {
        guard let data = basketData else { return }
        if data.count == 0 {
            emptyLabel.text = "텅~ 비었어요🫙"
        } else {
            emptyLabel.text = ""
        }
    }
    
    private func refreshTabBar(num: Int) {
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[2]
            tabItem.badgeValue = "\(num)"
            return
        }
    }
}

// MARK: - TableView Delegate
extension BasketViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            guard let selectedBurger = self.basketData?[indexPath.row] else { return }
            guard let selectedBurgerCount = self.basketCountDatas?[indexPath.row] else { return }
            self.countStepperDown(burger: selectedBurger, count: selectedBurgerCount)
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
        
        cell.titleLabel.text = item.burgerName
        cell.mainImage.image = item.burgerImage
        cell.priceLabel.text = price
        cell.countLabel.text = "\(count)"
        cell.countStepper.value = Double(count)
        print(count)
        return cell
    }
}

// MARK: - Tabbar Delegate
extension BasketViewController: UITabBarControllerDelegate {
    
}

// MARK: - Custom Delegate - StepButtonTypeDelegate
extension BasketViewController: StepButtonTypeDelegate {
    func countStepperUp(burger: McdonaldModel) {
        dataManager.addToBasket(burger: burger)
        updateDatas()
    }
    
    func countStepperDown(burger: McdonaldModel, count: Int) {
        dataManager.removeBasketData(burger: burger, count: count)
        updateDatas()
    }
    
    
}
