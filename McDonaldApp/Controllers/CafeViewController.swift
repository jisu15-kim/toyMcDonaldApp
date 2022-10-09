//
//  CafeViewController.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/09.
//

import UIKit

protocol CellButtonClickDelegate {
    func addToBasketButtonTapped(data: McdonaldModel)
}

class CafeViewController: UIViewController {
    
    var cafeArray: [McdonaldModel] = []
    var dataManager = DataManager()
    var numFormatter = NumberFormatter()
    
    @IBOutlet weak var cafeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDatas()
    }
    
    func setupTableView() {
        cafeTableView.delegate = self
        cafeTableView.dataSource = self
        cafeTableView.rowHeight = 120
    }
    
    func setupDatas() {
        dataManager.makeCafeData()
        cafeArray = dataManager.getCafeData()
    }


}

extension CafeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cafeTableView.dequeueReusableCell(withIdentifier: "CafeCell", for: indexPath) as! CafeCell
        let data = cafeArray[indexPath.row]
        
        var price: String {
            let value = data.price as NSNumber
            numFormatter.numberStyle = .decimal
            let result = numFormatter.string(from: value)
            return "\(result!)원"
        }
        
        // 셀의 이벤트를 받기 위한 Delegate 선언
        cell.delegate = self
        // cell의 데이터 설정
        cell.mainImage.image = data.image
        cell.mainKcal.text = "\(data.kcal)kcal"
        cell.mainPrice.text = price
        cell.mainTitle.text = data.name
        cell.cafeData = data
        
        return cell
    }
}

extension CafeViewController: UITableViewDelegate {
    
}

extension CafeViewController: CellButtonClickDelegate {
    func addToBasketButtonTapped(data: McdonaldModel) {
        print("VC로 넘어왔다")
        dataManager.addToBasket(burger: data)
    }
}
