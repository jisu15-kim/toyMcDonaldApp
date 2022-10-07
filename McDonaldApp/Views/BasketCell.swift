//
//  BasketCell.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/05.
//

import UIKit

class BasketCell: UITableViewCell {
    
    var delegate: StepButtonTypeDelegate?
    
    var item: McdonaldModel?
    var basketVC = BasketViewController()
    var itemCount: Double = 0.0
    
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var countStepper: UIStepper!
    @IBOutlet weak var removeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        setupData()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupUI() {
        mainImage.layer.cornerRadius = 30
        
    }
    
    func setupData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.itemCount = self.countStepper.value
            print("Value: \(self.countStepper.value)")
            print(self.itemCount)
        }
    }
    
    @IBAction func countStepperTapped(_ sender: UIStepper) {
        countLabel.text = Int(sender.value).description
        
        
        
        guard let data = item else { return }
        let gap = itemCount - sender.value
        if gap > 0 {
            // 마이너스 버튼 클릭됨
            print("마이너스 버튼 클릭됨")
            self.delegate?.countStepperDown(burger: data, count: 1)
            // basketVC.removeButton(burger: data, count: 1)
        } else if gap < 0 {
            // 플러스 버튼 클릭됨
            print("플러스 버튼 클릭됨")
            self.delegate?.countStepperUp(burger: data)
            // basketVC.addButton(burger: data)
        }
        itemCount = sender.value
    }
}

