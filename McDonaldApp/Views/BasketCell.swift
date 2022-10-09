//
//  BasketCell.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/05.
//

import UIKit
import DropDown

final class BasketCell: UITableViewCell {
    
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
    @IBOutlet weak var countSelector: UIButton!
    
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var btnSelect: UIButton!
    
    let dropDown = DropDown()
    
    let cointList: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        setupData()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    private func setupUI() {
        mainImage.layer.cornerRadius = 30
        
    }
    
    private func setupData() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.itemCount = self.countStepper.value
            print("Value: \(self.countStepper.value)")
            print(self.itemCount)
        }
    }
    
    // DropDown UI 커스텀
    func initUI() {
        // DropDown View의 배경
        dropView.backgroundColor = UIColor.init(named: "#F1F1F1")
        dropView.layer.cornerRadius = 8
        
        DropDown.appearance().textColor = UIColor.black // 아이템 텍스트 색상
        DropDown.appearance().selectedTextColor = UIColor.red // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(8)
        dropDown.dismissMode = .automatic // 팝업을 닫을 모드 설정
            
        tfInput.text = "선택해주세요." // 힌트 텍스트
            
        ivIcon.tintColor = UIColor.gray
    }
    
    @IBAction func countStepperTapped(_ sender: UIStepper) {
        countLabel.text = Int(sender.value).description
        
        // 지금은 임시방편 .. 어떻게 +와 - 를 구분할것인지?
        
        guard let data = item else { return }
        let gap = itemCount - sender.value
        if gap > 0 {
            // 마이너스 버튼 클릭됨
            print("마이너스 버튼 클릭")
            self.delegate?.countStepperDown(burger: data, count: 1)
        } else if gap < 0 {
            // 플러스 버튼 클릭됨
            print("플러스 버튼 클릭")
            self.delegate?.countStepperUp(burger: data)
        }
        itemCount = sender.value
        print("itemCount: \(itemCount)")
    }
}

