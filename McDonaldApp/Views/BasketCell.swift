//
//  BasketCell.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/05.
//

import UIKit

class BasketCell: UITableViewCell {
    
    var item: McdonaldModel?
    var basketVC = BasketViewController()
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countStepper: UIStepper!
    @IBOutlet weak var removeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupUI() {
        mainImage.layer.cornerRadius = 30
        removeButton.setTitle("", for: .normal)
    }
    
    func emptyUI() {
        
    }
}
