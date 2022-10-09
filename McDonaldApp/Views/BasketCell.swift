//
//  BasketCell.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/05.
//

import UIKit
import DropDown

final class BasketCell: UITableViewCell {
    
    var delegate: DropDownEventDelegate?
    
    var item: McdonaldModel?
    var basketVC = BasketViewController()
    var itemCount: Double = 0.0
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dropView: UIView!
    @IBOutlet weak var tfInput: UITextField!
    @IBOutlet weak var ivIcon: UIImageView!
    @IBOutlet weak var btnSelect: UIButton!
    
    let dropDown = DropDown()
    
    let countList: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        setupDropDownUI()
        setDropdown()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    private func setupUI() {
        mainImage.layer.cornerRadius = 30
        
    }
    
    // DropDown UI 커스텀
    func setupDropDownUI() {
        // DropDown View의 배경
        dropView.backgroundColor = .systemGray6
        dropView.layer.cornerRadius = 8
        
        DropDown.appearance().textColor = UIColor.black // 아이템 텍스트 색상
        DropDown.appearance().selectedTextColor = UIColor.red // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(8)
        dropDown.dismissMode = .automatic // 팝업을 닫을 모드 설정
        
        tfInput.text = "5" // 힌트 텍스트
        tfInput.textAlignment = .center
        tfInput.backgroundColor = .systemGray6
        tfInput.layer.borderColor = UIColor.clear.cgColor
        
        ivIcon.tintColor = UIColor.gray
        btnSelect.setTitle("", for: .normal)
    }
    // DropDown Set
    func setDropdown() {
        // dataSource로 ItemList를 연결
        let stringArray = countList.map {
            (number: Int) -> String in
            return String(number)
        }
        dropDown.dataSource = stringArray
        
        // anchorView를 통해 UI와 연결
        dropDown.anchorView = self.dropView
        
        // View를 갖리지 않고 View아래에 Item 팝업이 붙도록 설정
        dropDown.bottomOffset = CGPoint(x: 0, y: dropView.bounds.height)
        
        // Item 선택 시 처리
        dropDown.selectionAction = { [weak self] (index, count) in
            //선택한 Item을 TextField에 넣어준다.
            let intItem = Int(count)!
            guard let data = self!.item else { return }
            
            self!.tfInput.text = count
            self?.delegate?.setBasketData(burger: data, data: intItem)
            // self!.ivIcon.image = UIImage(systemName: "arrowtriangle.up.fill")
        }
        
        // 취소 시 처리
        dropDown.cancelAction = { [weak self] in
            //빈 화면 터치 시 DropDown이 사라지고 아이콘을 원래대로 변경
            // self!.ivIcon.image = UIImage(systemName: "arrowtriangle.down.fill")
        }
    }
    
    @IBAction func dropDownBtnTapped(_ sender: UIButton) {
        print("DROP 버튼이 눌렸어")
        dropDown.show()
        // 아이콘 이미지를 변경하여 DropDown이 펼쳐진 것을 표현
        // self.ivIcon.image = UIImage(systemName: "arrowtriangle.up.fill")
    }
}
