//
//  ProfileModel.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/20/20.
//

import Foundation
import RxSwift

struct Profile : Codable {
    var id: Int? = nil
    var avatar_url: String? = nil
    var name: String? = nil
}
class ProfileModel {
    let url = URL(string: "https://api.github.com/users/bacsonvv")
    var profile: Profile?
    var profileSubject = PublishSubject<Profile>()
    
    init(p: Profile) {
        self.profile = p
    }
    func fetchAPI(){
        guard let finalURL = url else {return}
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            guard let data = data, error == nil, response != nil else {return}
             print("download")
            do {
                self.profile = try JSONDecoder().decode(Profile.self, from: data)
                guard let profileData = self.profile else {return}
                self.profileSubject.onNext(profileData)
            } catch {
                print("something wrong with decode")
            }
        }.resume()
    }
}
