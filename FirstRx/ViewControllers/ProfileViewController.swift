//
//  ProfileViewController.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/20/20.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var lbName: UILabel!
    var profileModel = ProfileModel(p: Profile())
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        profileModel.fetchAPI()
        loadData()
    }
    
    
    func loadData(){
        profileModel.profileSubject.subscribe { (profile) in
            self.profileModel.profile = profile.element
            DispatchQueue.main.async {
                self.lbName.text = profile.element?.name
                if let imageUrl = URL(string: (profile.element?.avatar_url)!){
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: imageUrl)
                        if let data = data {
                            DispatchQueue.main.async {
                                self.imageView.image = UIImage(data: data)
                            }
                            
                        }
                    }
                }
            }
            
        }.disposed(by: disposeBag)
    }
    

}
