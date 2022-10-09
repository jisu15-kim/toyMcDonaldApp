//
//  McdonaldModel.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/04.
//

import UIKit
enum MenuType: Int {
    case burger = 1
    case cafe = 2
}

struct McdonaldModel: Hashable {
    
    var name: String
    var image: UIImage?
    var kcal: Int
    var price: Int
    var type: MenuType
}
