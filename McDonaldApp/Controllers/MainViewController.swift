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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupTableView()
        title = "버거 Burger"
        
    }
    
    func setupData() {
        dataManager.makeBurgerData()
        burgerArray = dataManager.getBurgerData()
    }
    
    func setupTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.rowHeight = 120
        
    }
    
    func addBasket(burger: McdonaldModel) {
        dataManager.addToBasket(burger: burger)
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
        
        
        cell.mainTitle.text = burger.burgerName
        cell.kcalLabel.text = "\(burger.kcal)kcal"
        cell.mainImage.image = burger.burgerImage
        cell.priceLabel.text = "\(burger.price)원"
        
        return cell
    }
    
    
}
