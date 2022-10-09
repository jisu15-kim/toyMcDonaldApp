//
//  CafeCell.swift
//  McDonaldApp
//
//  Created by 김지수 on 2022/10/09.
//

import UIKit

class CafeCell: UITableViewCell {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var mainTitle: UILabel!
    @IBOutlet weak var mainKcal: UILabel!
    @IBOutlet weak var mainPrice: UILabel!
    var delegate: CellButtonClickDelegate?
    var cafeData: McdonaldModel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func addButtonTapped(_ sender: UIButton) {
        print("버튼이 눌렸다")
        guard let data = cafeData else { return }
        delegate?.addToBasketButtonTapped(data: data)
    }
}
