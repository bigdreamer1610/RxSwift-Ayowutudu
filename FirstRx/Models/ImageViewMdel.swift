//
//  ImageViewMdel.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/19/20.
//

import Foundation
import RxSwift
import RxCocoa

class ImageViewModel {
    //MARK: - Attributes
    var index: Int
    var imageURL: String
    var subject = PublishSubject<Data>()
    
    init(_ index: Int, _ imageUrl: String) {
        self.index = index
        self.imageURL = imageUrl
    }
    
    //async func to download the cell image/thumbnail
    
    func fetchImage(){
        if let imageUrl = URL(string: self.imageURL){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl)
                if let data = data {
                    self.subject.onNext(data)
                }
            }
        }
    }
}


