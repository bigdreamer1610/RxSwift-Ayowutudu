//
//  AppRouter.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/16/20.
//

import UIKit

enum RouterType {
    case first
    case second
}

extension RouterType{
    func getVc() -> UIViewController {
        switch self {
        case .first:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "first_vc") as! ViewController
            return vc
        default:
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "second_vc") as! SecondViewController
            return vc
        }
    }
}
