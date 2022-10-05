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
    var dataManager = DataManager()
    let tabBar = UITabBarItem()
    let numberFormatter = NumberFormatter()
    var totalPrice: Int = 0 {
        didSet {
            let value = totalPrice as NSNumber
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: value)
            totalPriceLabel.text = "\(result!)원"
        }
    }
    
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
        setupTableView()
        refreshTabBar(num: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDatas()
        basketTableView.reloadData()
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
    
    func setupDatas() {
        self.basketData = dataManager.getBasketData()
        totalPrice = dataManager.getTotalPrice()
    }
    
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        let contentView = sender.superview
        let cell = contentView?.superview as! UITableViewCell
        
        guard let indexPath = basketTableView.indexPath(for: cell)?.row else { return }
        
        dataManager.removeBasketItem(index: indexPath)
        setupDatas()
        basketTableView.reloadData()
    }
}

extension BasketViewController: UITableViewDelegate {
    
}

extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let data = basketData else { return 0 }
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = basketTableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketCell
        
        guard let array = basketData else { return cell }
        let item = array[indexPath.row]
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
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
    //
    //        return "This is table footer"
    //    }
}

extension BasketViewController: UITabBarControllerDelegate {
    
}
