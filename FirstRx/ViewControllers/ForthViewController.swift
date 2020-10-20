//
//  ForthViewController.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/20/20.
//

import UIKit
import RxSwift
import RxRelay


class ForthViewController: UIViewController {

    @IBOutlet var lbCount: UILabel!
    @IBOutlet var btnClick: UIButton!
    
    @IBOutlet var lbCheck: UILabel!
    @IBOutlet var textCheck: UITextField!
    let array: BehaviorRelay<[Int]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpObserver()
        lbCheck.text = ""

        // Do any additional setup after loading the view.
    }

    @IBAction func clickButton(_ sender: Any) {
       /*
         let newValue =  ShoppingCart.sharedCart.chocolates.value + [chocolate]
         ShoppingCart.sharedCart.chocolates.accept(newValue)
         */
        let newValue = array.value + [4]
        array.accept(newValue)
    }
    
    func setUpObserver(){
        array.asObservable().subscribe { [unowned self] (a) in
            self.lbCount.text = "\(self.array.value.count)"
        }.disposed(by: disposeBag)

        textCheck.rx.text.orEmpty.subscribe { (text) in
            self.lbCheck.text = text
        }.disposed(by: disposeBag)
        
    }
    
}
