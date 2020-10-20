//
//  SecondViewController.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/16/20.
//

import UIKit
import RxSwift
import RxCocoa

var count = 0
class SecondViewController: BaseViewController {

    @IBOutlet var loading: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var searchBar: SearchBar!
    @IBOutlet var lbError: UILabel!
    //MARK: - Attributes
    let songModel = SongModel()
    let songModelDisplay = SongModel()
    var imageModel = ImageViewModel(0, "")
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        songModel.delegate = self
        loading.isHidden = true
        lbError.isHidden = true
        tableView.isHidden = true
        initComponents()
        initData()
        addObservetoSearchBar()
    }

    func initComponents(){
        SongCell.registerCellByNib(tableView)
        tableView.rowHeight = 80
        tableView.dataSource = self
    }
    
    func initData(){
        songModel.fetchAPI()
        songModel.songSubject.subscribe(onNext: { data in
            self.songModel.songs = data
            self.songModelDisplay.songs = data
            count += 1
            print("Cell count: \(count)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }).disposed(by: disposeBag)
        
    }
    
    func addObservetoSearchBar(){
        searchBar.rx.text
            .orEmpty
            .filter { !$0.isEmpty
            }
            .subscribe(onNext: { [unowned self] query in
                self.songModelDisplay.songs = self.songModel.songs.filter { ($0.title?.hasPrefix(query))!}
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    func bindData(){
    }

}

extension SecondViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.songModelDisplay.songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = SongCell.loadCell(tableView) as? SongCell else {return UITableViewCell()}
        imageModel = ImageViewModel(indexPath.row, self.songModelDisplay.songs[indexPath.row].thumbnailUrl ?? "")
        imageModel.fetchImage()
        imageModel.subject.subscribe(onNext: {data in
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                cell.albumImage.image = image
                cell.title.text = self.songModel.songs[indexPath.row].title
            }
        }).disposed(by: disposeBag)
        return cell
    }
    
    
}

extension SecondViewController : SecondViewControllerDelegate {
    func startLoading() {
        DispatchQueue.main.async {
            self.tableView.isHidden = true
            self.loading.isHidden = false
            self.loading.startAnimating()
        }
    }
    
    func endLoading() {
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.loading.stopAnimating()
            self.loading.isHidden = true
        }
    }
    
    func failLoading() {
        DispatchQueue.main.async {
            self.loading.isHidden = true
            self.loading.stopAnimating()
            self.lbError.isHidden = false
            self.tableView.isHidden = true
        }
       
    }
}
