//
//  ViewController.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/04.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainTableView: UITableView!
    
    var dataManager = DataManager()
    var burgerArray: [McdonaldModel] = []
    var basketArray: [Int] = []
    var basketVC = BasketViewController()
    var numFormatter = NumberFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupTableView()
        title = "버거 Burger"
        
    }
    
    func setupData() {
        dataManager.makeBurgerData()
        burgerArray = dataManager.getBurgerData()
        refreshTabBar(num: 0)
        basketArray = dataManager.getBasketDataCounts()
        tabBarController?.delegate = self
    }
    
    func setupTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 120
    }
    
    func setupTabbar() {
        
    }
    
    func addBasket(burger: McdonaldModel) {
        dataManager.addToBasket(burger: burger)
        refreshBasket()
    }
    
    func refreshBasket() {
        basketArray = dataManager.getBasketDataCounts()
        var data = 0
        for array in basketArray {
            data += Int(array)
        }
        refreshTabBar(num: data)
        print(data)
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

extension MainViewController: UITableViewDelegate {
    
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return burgerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        
        let array = burgerArray
        let burger = array[indexPath.row]
        cell.burger = burger
        
        var price: String {
            let value = burger.price as NSNumber
            numFormatter.numberStyle = .decimal
            let result = numFormatter.string(from: value)
            return "\(result!)원"
        }
        
        cell.mainTitle.text = burger.burgerName
        cell.kcalLabel.text = "\(burger.kcal)kcal"
        cell.mainImage.image = burger.burgerImage
        cell.priceLabel.text = price
        
        return cell
    }
    
    
}

extension MainViewController: UITabBarControllerDelegate {
    
}
