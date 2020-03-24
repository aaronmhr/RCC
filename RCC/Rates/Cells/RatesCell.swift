//
//  RatesCell.swift
//  RCC
//
//  Created by Aaron Huánuco on 21/03/2020.
//  Copyright © 2020 Aaron Huánuco. All rights reserved.
//

import UIKit
import Presentation

final class RatesCell: UITableViewCell, NibReusable {
    @IBOutlet private var originTitle: UILabel!
    @IBOutlet private var originSubtitle: UILabel!
    @IBOutlet private var destinationTitle: UILabel!
    @IBOutlet private var destinationSubtitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyles()
    }
    
    private func setupStyles() {
        originTitle.style = LabelStyles.medium20Black
        originSubtitle.style = LabelStyles.regular14Gray
        destinationTitle.style = LabelStyles.medium20Black
        destinationSubtitle.style = LabelStyles.regular14Gray
    }
    
    public func configureCell(_ cell: ExchangePairView) {
        originTitle.text = cell.origin.title
        originSubtitle.text = cell.origin.subtitle
        destinationTitle.attributedText = cell.destination.title.ratesCellAttributed
        destinationSubtitle.text = cell.destination.subtitle
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        originTitle.text = nil
        originSubtitle.text = nil
        destinationTitle.text = nil
        destinationSubtitle.text = nil
    }
}

extension String {
    var ratesCellAttributed: NSAttributedString {
        guard count > 2,
            let startIndexSecond = index(endIndex, offsetBy: -2, limitedBy: startIndex) else {
                return NSAttributedString(string: self)
        }
        let result = NSMutableAttributedString()
        let start = NSAttributedString(
            string: String(self[..<startIndexSecond]),
            attributes: [.font : UIFont.medium20, .foregroundColor : UIColor.rccBlack])
        let end = NSAttributedString(
            string: String(self[startIndexSecond...]),
            attributes: [.font : UIFont.medium16, .foregroundColor : UIColor.rccBlack])
        result.append(start)
        result.append(end)
        return result
    }
}
