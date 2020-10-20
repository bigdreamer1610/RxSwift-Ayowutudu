//
//  SearchBar.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/16/20.
//

import UIKit

@IBDesignable
class SearchBar: UISearchBar {

    @IBInspectable
    var mybackgroundColor: UIColor = UIColor.green
    @IBInspectable
    var isOne: Bool = false
    @IBInspectable
    var search: String = "Test"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if isOne {
            self.backgroundColor = mybackgroundColor
        }
        
        
    }
    /*
     @IBInspectable
     var isCircle:Bool = false
     @IBInspectable
     var borderColorCustom:UIColor = UIColor.clear
     @IBInspectable
     var borderWidthCustom:CGFloat = 0.0
     override func layoutSubviews() {
         super.layoutSubviews()
         if isCircle {
             self.layer.masksToBounds = true
             self.layer.cornerRadius = self.frame.width / 2
         }
         self.layer.borderColor = borderColorCustom.cgColor
         self.layer.borderWidth = borderWidthCustom
     }
    */

}
