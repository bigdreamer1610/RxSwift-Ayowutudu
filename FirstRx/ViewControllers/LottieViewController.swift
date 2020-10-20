//
//  LottieViewController.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/19/20.
//

import UIKit
import Lottie
import SnapKit
import RxSwift
import RxCocoa

class LottieViewController: UIViewController {

    
    @IBOutlet var centerView: UIView!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfUsername: UITextField!
    
    @IBOutlet var messUsername: UILabel!
    
    @IBOutlet var messPassword: UILabel!
    @IBOutlet var btnLogin: UIButton!
    
    var isValidUsername: Observable<Bool> {
        return self.tfUsername.rx.text.asObservable().map {
            $0!.count >= 4 && $0!.hasPrefix("ayo")
        }
    }
    
    var isValidPassword: Observable<Bool> {
        return self.tfPassword.rx.text.asObservable().map {
            $0!.count >= 6
        }
    }
    
    var isValid: Observable<Bool> {
        return Observable.combineLatest(isValidUsername,isValidPassword) {$0 && $1}
    }
    let box = UIView()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeLayout()
        addAnimation()
        validateLogin()
        messUsername.isHidden = true
        messPassword.isHidden = true
        tfUsername.delegate = self
        tfPassword.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func customizeLayout(){
        view.addSubview(box)
        box.backgroundColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        box.snp.makeConstraints { (make) in
            make.width.equalTo(centerView).multipliedBy(0.1)
            make.height.equalTo(centerView).multipliedBy(0.1)
            make.centerX.equalToSuperview()
            make.top.equalTo(centerView.snp.bottom).offset(20)
        }
    }
    //MARK: - Lottie Animation
    func addAnimation(){
        let animation = AnimationView(name: "36222-couple")
        centerView.contentMode = .scaleAspectFit
        centerView.addSubview(animation)
        animation.frame = centerView.bounds
        animation.loopMode = .loop
        animation.play()
    }
    
    func validateLogin(){
        // subscribe isValid variable to
        isValid.subscribe {[weak self] (valid) in
            guard let `self` = self, let isValid = valid.element else {return}
            `self`.btnLogin.isEnabled = isValid
            `self`.btnLogin.backgroundColor = isValid ? #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1) : #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1).withAlphaComponent(0.7)
        }.disposed(by: disposeBag)
        
        //hidden state for message username
        tfUsername.rx.text.subscribe { (text) in
            self.messUsername.isHidden = text.element! == ""
        }.disposed(by: disposeBag)
        
        //hideen state for message password
        tfPassword.rx.text.subscribe { (text) in
            self.messPassword.isHidden = text.element! == ""
        }.disposed(by: disposeBag)
    }
    

}

//MARK: - subscribe to variable to switch message content
extension LottieViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.tfUsername:
            self.isValidUsername.subscribe { (valid) in
                self.messUsername.text = valid.element! ? "Valid username" : "Invalid username"
                self.messUsername.textColor = valid.element! ? #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1) : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }.disposed(by: disposeBag)
        case self.tfPassword:
            self.isValidPassword.subscribe { (valid) in
                self.messPassword.text = valid.element! ? "Valid password" : "Invalid password"
                self.messPassword.textColor = valid.element! ? #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1) : #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            }.disposed(by: disposeBag)
        default:
            return
        }
    }

}
