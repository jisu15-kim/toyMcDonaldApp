//
//  CafeViewController.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/04.
//

import UIKit

class BasketViewController: UIViewController {
    
    var basketData: [McdonaldModel]?
    var dataManager = DataManager()
    
    @IBOutlet weak var basketTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatas()
        setupTableView()
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
    
    func setupDatas() {
        self.basketData = dataManager.getBasketData()
    }
    
//    func removeItem(item: McdonaldModel, index: Int) {
//        dataManager.removeBasketItem(item: item, index: index)
//    }
    
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
        
        
        cell.titleLabel.text = item.burgerName
        cell.mainImage.image = item.burgerImage
        cell.priceLabel.text = "\(item.price)원"
        return cell
    }
}
