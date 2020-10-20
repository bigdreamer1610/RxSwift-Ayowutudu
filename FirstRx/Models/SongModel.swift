//
//  SongModel.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/19/20.
//

import Foundation
import RxSwift

protocol SecondViewControllerDelegate: class {
    func startLoading()
    func endLoading()
    func failLoading()
}
class SongModel {
    //MARK: - Data Attributes
    
    let url = URL(string: "https://jsonplaceholder.typicode.com/albums/1/photos")
    var songs = [Song]()
    var songSubject = PublishSubject<[Song]>() //notify when celldata is loaded from JSON URL session
    var delegate: SecondViewControllerDelegate?
    init() {
        self.songs = []
    }
    
    //download data and decode the json info from url
    
    func fetchAPI(){
        delegate?.startLoading()
        guard let finalURL = url else {return}
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            guard let data = data, error == nil, response != nil else {
                print("Something happend")
                self.delegate?.failLoading()
                return
            }
            print("Download json")
            
            do {
                self.songs = try JSONDecoder().decode([Song].self, from: data)
                self.songSubject.onNext(self.songs)
            } catch {
                print("Decode error")
            }
            self.delegate?.endLoading()
        }.resume()
    }
}
