//
//  TableViewButton.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/04.
//

import UIKit

protocol HeaderViewDelegate: AnyObject { // class로 타입 제한
    func didSelectedPriceButton()
    func didSelectedVolumeButton()
}

class TableViewButton: UITableViewHeaderFooterView {

    var delegate: HeaderViewDelegate? // 의존성 주입할 프로퍼티 선언

    let priceButton = UIButton()
    let volumButton = UIButton()
    
@objc func didSelectedPriceButton(_ sender: UIButton) {
        delegate?.didSelectedPriceButton()
    }
    
@objc func didSelectedVolumeButton(_ sender: UIButton) {
        delegate?.didSelectedVolumeButton()
    }
    
 }
