//
//  ViewController.swift
//  FirstRx
//
//  Created by THUY Nguyen Duong Thu on 10/16/20.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: BaseViewController {
    
    let network: NetworkManager = NetworkManager.sharedInstance

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var btnNext: NextButton!
    
    var data = ["Jennie","Monie","Tom","Lisa","Jisoo","Rose"]
    var displayData = [String]()
    
    let collections = [1,2,3,4,5,6,7]
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        MemberCell.registerCellByNib(tableView)
        observeSearchBar()
        test()
        test2()
        //tableViewUsingRx()
        // Do any additional setup after loading the view.
    }
    
    func observeSearchBar(){
        //observe on next: when text in searchbar change
        self.searchBar.rx.text.subscribe(onNext: {element in
            self.displayData = self.data.filter({ $0.hasPrefix(element!)
            })
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    func tableViewUsingRx(){
        let items = Observable.just(data)
        items
        .bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = MemberCell.loadCell(tableView) as! MemberCell
            cell.label.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
    }
    
    func test(){
        let sequence = Observable.from(collections)
        sequence.subscribe { (event) in
            print(event)
        } onError: { (error) in
            print("there is error")
        } onCompleted: {
            print("completed")
        } onDisposed: {
            print("dispose")
        }.disposed(by: disposeBag)
         
    }
    
    func test2() {
        let dope = [1,2,3]
        let no = ["One","Two","Three"]
        let sequence = Observable.just(no)
        sequence.subscribe { (element) in
            print("Alo: \(element)")
        }.disposed(by: disposeBag)
        print("F done")
    }
    
    
    @IBAction func clickNext(_ sender: Any) {
        self.navigationController?.pushViewController(RouterType.second.getVc(), animated: true)
    }
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MemberCell.loadCell(tableView) as! MemberCell
        cell.label.text = displayData[indexPath.row]
        return cell
    }
}

