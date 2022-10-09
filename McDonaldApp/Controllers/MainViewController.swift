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
        dataManager.calculTotalPrice()
        dataManager.makeBurgerData()
        burgerArray = dataManager.getBurgerData()
        basketArray = dataManager.getBasketDataCounts()
    }
    
    func setupTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 120
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
        print(data)
//        fetchTabBarData(data: data)
    }
    func setupTabBar() {
        UITabBar.appearance().tintColor = UIColor.black
    }
    
    func fetchTabBarData(data: Int) {
        print("메인VC Fetch 함수 호출")
        
        // self.delegate?.fetchBadgeData(count: data)
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
        
        cell.mainTitle.text = burger.name
        cell.kcalLabel.text = "\(burger.kcal)kcal"
        cell.mainImage.image = burger.image
        cell.priceLabel.text = price
        
        return cell
    }
    
    
}
