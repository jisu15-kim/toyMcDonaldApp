//
//  DataManager.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/04.
//

import UIKit


final class DataManager {
    
    private var burgerArray: [McdonaldModel] = []
    private static var basketArray: [McdonaldModel] = []
    private static var total = 0
    
    
    // MARK: - 버거 데이터 관련 함수
    
    func makeBurgerData() {
        burgerArray = [
            McdonaldModel(burgerName: "1955", burgerImage: UIImage(named: "1955"), kcal: 583, price: 4800),
            McdonaldModel(burgerName: "베이컨 토마토 디럭스 버거", burgerImage: UIImage(named: "BaconTomatoDeluxe"), kcal: 583, price: 5800),
            McdonaldModel(burgerName: "빅맥", burgerImage: UIImage(named: "BigMac"), kcal: 583, price: 4900),
            McdonaldModel(burgerName: "더블 필레 오 피쉬", burgerImage: UIImage(named: "DoubleFiletOFish"), kcal: 583, price: 5200),
            McdonaldModel(burgerName: "더블 쿼터파운더 치즈", burgerImage: UIImage(named: "DoubleQuarterPounderCheese"), kcal: 583, price: 7400),
            McdonaldModel(burgerName: "필레 오 피쉬", burgerImage: UIImage(named: "FiletOFish"), kcal: 583, price: 3200),
            McdonaldModel(burgerName: "맥치킨 모짜렐라", burgerImage: UIImage(named: "McChickenMozzarella"), kcal: 583, price: 5000),
            McdonaldModel(burgerName: "맥 크리스피 클래식", burgerImage: UIImage(named: "McCrispyClassic"), kcal: 583, price: 5900),
            McdonaldModel(burgerName: "맥 크리스피 디럭스", burgerImage: UIImage(named: "McCrispyDeluxe"), kcal: 583, price: 6700),
            McdonaldModel(burgerName: "맥 스파이시 상하이", burgerImage: UIImage(named: "McSpicyShanghai"), kcal: 583, price: 4900),
            McdonaldModel(burgerName: "슈비버거", burgerImage: UIImage(named: "ShrimpBeefBurger"), kcal: 583, price: 5800)
        ]
    }
    
    func getBurgerData() -> [McdonaldModel] {
        return burgerArray
    }
    
    // MARK: - 장바구니 관련 함수
    
    func addToBasket(burger: McdonaldModel) {
        DataManager.basketArray.append(burger)
        calculTotalPrice()
    }
    
    func calculTotalPrice() {
        DataManager.total = 0
        for array in DataManager.basketArray {
            DataManager.total += array.price
        }
        print("Total: \(DataManager.total)")
    }
    
    func getBasketData() -> [McdonaldModel] {
        
        return DataManager.basketArray
    }
    
    func removeBasketItem(index: Int) {
        DataManager.basketArray.remove(at: index)
        calculTotalPrice()
    }
    
    func getTotalPrice() -> Int {
        return DataManager.total
    }
}
