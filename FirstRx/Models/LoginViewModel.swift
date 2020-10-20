//
//  LoginModel.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/20/20.
//

import Foundation
import UIKit
import RxSwift

class LoginViewModel {

    
}

/*
 import RxSwift
 
 class LoginViewModel {
     
     // Khai báo biến để hứng dữ liệu từ VC
     var usernameText = Variable<String>("")
     var passwordText = Variable<String>("")
     
     
     // Khai báo viến Bool để lắng nghe sự kiện và trả về kết quả thoả mãn điều kiện
     var isValidUsername: Observable<Bool> {
         return    self.usernameText.asObservable().map { username in
             username.count >= 6
         }
     }
     
     var isValidPassword: Observable<Bool> {
         return self.passwordText.asObservable().map {
             password in
             password.count >= 6
         }
     }
     
     // Khai báo biến để lắng nghe kết quả của cả 2 sự kiện trên
     
     var isValid: Observable<Bool> {
         return Observable.combineLatest(isValidUsername, isValidPassword) {$0 && $1}
     }
 }

 */
