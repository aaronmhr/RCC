//
//  CurrencyCell.swift
//  RCC
//
//  Created by Aaron Huánuco on 22/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit
import Presentation

final class CurrencyCell: UITableViewCell, NibReusable {
    @IBOutlet private var flag: UIImageView!
    @IBOutlet private var codeLabel: UILabel!
    @IBOutlet private var currencyName: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(with currency: CurrencyView) {
        flag.image = UIImage(imageLiteralResourceName: currency.code)
        codeLabel.text = currency.code
        currencyName.text = currency.name
        contentView.alpha = currency.isActive ? Constants.activeAlpha : Constants.disabledAlpha
        isUserInteractionEnabled = currency.isActive
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        flag.image = nil
        codeLabel.text = nil
        currencyName.text = nil
        alpha = Constants.activeAlpha
    }
    
    private enum Constants {
        static let activeAlpha: CGFloat = 1.0
        static let disabledAlpha: CGFloat = 0.2
    }
}
