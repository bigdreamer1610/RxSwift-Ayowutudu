//
//  NextButton.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/16/20.
//

import UIKit

@IBDesignable
class NextButton: UIButton {

    @IBInspectable
    var backColor: UIColor = #colorLiteral(red: 0.3929189782, green: 0.4198221317, blue: 0.8705882353, alpha: 1)
    @IBInspectable
    var textColorr: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = backColor
        setTitleColor(textColorr, for: .normal)
    }

}
