//
//  DataManager.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/04.
//

import UIKit


final class DataManager {
    
    private var burgerArray: [McdonaldModel] = []
    private var cafeArray: [McdonaldModel] = []
    private static var basketDictionary: [McdonaldModel:Int] = [:]
    private static var total = 0
    private static var totalcounts = 0
    
//    private static let tabBarController = UITabBarController()
    
    
    // MARK: - 버거 데이터 관련 함수
    
    func makeBurgerData() {
        burgerArray = [
            McdonaldModel(name: "1955", image: UIImage(named: "1955"), kcal: 583, price: 4800, type: .burger),
            McdonaldModel(name: "베이컨 토마토 디럭스 버거", image: UIImage(named: "BaconTomatoDeluxe"), kcal: 583, price: 5800, type: .burger),
            McdonaldModel(name: "빅맥", image: UIImage(named: "BigMac"), kcal: 583, price: 4900, type: .burger),
            McdonaldModel(name: "더블 필레 오 피쉬", image: UIImage(named: "DoubleFiletOFish"), kcal: 583, price: 5200, type: .burger),
            McdonaldModel(name: "더블 쿼터파운더 치즈", image: UIImage(named: "DoubleQuarterPounderCheese"), kcal: 583, price: 7400, type: .burger),
            McdonaldModel(name: "필레 오 피쉬", image: UIImage(named: "FiletOFish"), kcal: 583, price: 3200, type: .burger),
            McdonaldModel(name: "맥치킨 모짜렐라", image: UIImage(named: "McChickenMozzarella"), kcal: 583, price: 5000, type: .burger),
            McdonaldModel(name: "맥 크리스피 클래식", image: UIImage(named: "McCrispyClassic"), kcal: 583, price: 5900, type: .burger),
            McdonaldModel(name: "맥 크리스피 디럭스", image: UIImage(named: "McCrispyDeluxe"), kcal: 583, price: 6700, type: .burger),
            McdonaldModel(name: "맥 스파이시 상하이", image: UIImage(named: "McSpicyShanghai"), kcal: 583, price: 4900, type: .burger),
            McdonaldModel(name: "슈비버거", image: UIImage(named: "ShrimpBeefBurger"), kcal: 583, price: 5800, type: .burger)
        ]
    }
    
    func makeCafeData() {
        cafeArray = [
            McdonaldModel(name: "카페라떼", image: UIImage(named: "CafeLatte"), kcal: 583, price: 3000, type: .cafe),
            McdonaldModel(name: "디카페인 카페라떼", image: UIImage(named: "DecaffeineCafeLatte"), kcal: 583, price: 3500, type: .cafe),
            McdonaldModel(name: "아이스 카페라떼", image: UIImage(named: "IcedCafeLatte"), kcal: 583, price: 3600, type: .cafe),
            McdonaldModel(name: "바닐라라떼", image: UIImage(named: "VanillaLatte"), kcal: 583, price: 4000, type: .cafe),
            McdonaldModel(name: "아이스 바닐라라떼", image: UIImage(named: "IcedVanillaLatte"), kcal: 583, price: 4200, type: .cafe),
            McdonaldModel(name: "슈퍼제주 한라봉칠러", image: UIImage(named: "Jeju Hallabong ChiJejuHallabongChiller"), kcal: 583, price: 4500, type: .cafe),
            McdonaldModel(name: "맥 너겟", image: UIImage(named: "McNuggets"), kcal: 583, price: 2500, type: .cafe),
            McdonaldModel(name: "상하이 치킨랩", image: UIImage(named: "ShanghaiChickenSnackWrap"), kcal: 583, price: 3000, type: .cafe),
            McdonaldModel(name: "초콜릿쉐이크 Medium", image: UIImage(named: "ChocolateShakeMedium"), kcal: 583, price: 4500, type: .cafe),
            McdonaldModel(name: "바닐라쉐이크 Medium", image: UIImage(named: "VanillaShakeMedium"), kcal: 583, price: 4500, type: .cafe),
            McdonaldModel(name: "딸기쉐이크 Medium", image: UIImage(named: "StrawberryShakeMedium"), kcal: 583, price: 4500, type: .cafe)
        ]
    }
    
//    func refreshTabBar() {
//        print("Refresh 탭바 !!!!")
//
//        DataManager.tabBarController.items![1] as! UITabBarItem).badgeValue = "1"
//
//
//            if let tabBarController = rootViewController as? UITabBarController {
//                print("tab")
//                let tabBarItem = tabBarController.tabBar.items![3]
//                tabBarItem.badgeValue = "!"
//            }
//        }
//
//        DataManager.tabBarController.tabBar.items![2].badgeValue = "\(self.getCalculTotalCount())"
////        if let tabItems = DataManager.tabBarController.tabBar.items {
////            // In this case we want to modify the badge number of the third tab:
////            let tabItem = tabItems[2]
////            tabItem.badgeValue = "\(self.getCalculTotalCount())"
////            return
////        }
//    }
    
    // MARK: - 데이터 계산 및 전달
    
    func calculTotalPrice() {
        DataManager.total = 0
        let data = DataManager.basketDictionary
        for array in data {
            DataManager.total += array.key.price * array.value
        }
        let count = getCalculTotalCount()
        NotificationCenter.default.post(name: .fetchTabBarBadge, object: count)
        print("총 금액: \(DataManager.total)")
    }
    
    func getCalculTotalCount() -> Int {
        DataManager.totalcounts = 0
        let data = DataManager.basketDictionary
        for array in data {
            DataManager.totalcounts += array.value
        }
        return DataManager.totalcounts
    }
    
    func getBurgerData() -> [McdonaldModel] {
        return burgerArray
    }
    
    func getCafeData() -> [McdonaldModel] {
        return cafeArray
    }
    
    func getTotalPrice() -> Int {
        return DataManager.total
    }
    // MARK: - 장바구니 관련 함수
    
    func addToBasket(burger: McdonaldModel) {
        let result = DataManager.basketDictionary.keys.contains(burger)
        var count = DataManager.basketDictionary[burger]

        if result == true {
            count! += 1
            DataManager.basketDictionary.updateValue(count!, forKey: burger)
        } else {
            DataManager.basketDictionary.updateValue(1, forKey: burger)
        }
        calculTotalPrice()
    }
    
    // 장바구니 데이터 리턴
    func getBasketData() -> [McdonaldModel:Int] {
        let original = DataManager.basketDictionary
        
        // 버거, 카페 로 그룹화 필요
        
        return original
    }
    
    // 장바구니 카운트 리턴
    func getBasketDataCounts() -> [Int] {
        let data = Array(DataManager.basketDictionary.values)
        return data
    }

    // 장바구니 수량 세팅
    func setNewBasketData(burger: McdonaldModel, data: Int) {
        if data == 0 {
            DataManager.basketDictionary.removeValue(forKey: burger)
        } else {
            DataManager.basketDictionary.updateValue(data, forKey: burger)
        }
        calculTotalPrice()
    }
}


