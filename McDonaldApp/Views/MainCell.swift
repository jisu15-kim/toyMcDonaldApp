//
//  MainCell.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/04.
//

import UIKit

// 1) cell에 Protocol을 만들어준다.
// 위치 : TableViewCell

// 범용성을 위해 class가 아닌 AnyObject로 선언해준다.
protocol ContentsMainTextDelegate: AnyObject {
    // 위임해줄 기능
    func categoryButtonTapped()
}

class MainCell: UITableViewCell {
    
    var cellDelegate: ContentsMainTextDelegate?
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var kcalLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var basketButton: UIButton!
    
    var burger: McdonaldModel?
    var mainVC = MainViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 16, bottom: 5, right: 16))
        contentView.layer.cornerRadius = 10
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        if selected {
//            contentView.layer.borderWidth = 2
//            contentView.layer.borderColor = UIColor.blue.cgColor
//        } else {
//            contentView.layer.borderWidth = 1
//            contentView.layer.borderColor = UIColor.clear.cgColor
//        }
    }
    
    func setupUI() {
        basketButton.layer.cornerRadius = basketButton.frame.height / 2
        self.selectionStyle = .blue
    }
    
    @IBAction func basketButtonTapped(_ sender: UIButton) {
        guard let bur = burger else { return }
        mainVC.addBasket(burger: bur)
        //print("버튼이 눌렸다")
    }
    


}
