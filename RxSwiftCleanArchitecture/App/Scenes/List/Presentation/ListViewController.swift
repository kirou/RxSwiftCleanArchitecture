//
//  ListViewController.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/12.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter : ListPresenterProtocol!
    var router : ListRouterProtocol!
    
    let disposeBag = DisposeBag()
    let tableViewRefreshControl = UIRefreshControl()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ListConfigurator.sharedInstance.configure(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 基本的にはStoryboard側でdelegateとdatasourceをひも付けちゃう方がいいですが
        // 今回はコードの方に記載しました
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.addSubview(tableViewRefreshControl)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        setSubscribe()
        presenter.load()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

/**
 * tableViewあたりはRxCocoaとか標準のものかお好みで
 * 今回は、タップ時のページ遷移はrx_itemSelectedを用いて、残りは標準のものを利用しています
 */
extension ListViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView : UITableView, numberOfRowsInSection section : Int) -> Int {
        return presenter.viewModels.contentsList.count ?? 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ListTableViewCell", forIndexPath: indexPath) as! ListTableViewCell
        
        guard indexPath.section == 0 && presenter.viewModels.contentsList.count > indexPath.item else {
            return cell
        }
        
        cell.bindData(viewModel : presenter.viewModels.contentsList[indexPath.row])
        return cell
    }
}

private extension ListViewController {
    
    func setSubscribe() {
        
        presenter.viewReloadData.asObserver().filter{ $0 == true}.subscribeNext { [unowned self] _ in
            self.errorView.hidden = true
            self.tableView.hidden = false
            self.tableView.reloadData()
        }.addDisposableTo(disposeBag)
        
        presenter.viewErrorPage.asObserver().filter {$0 == true}.subscribeNext { [unowned self] _ in
            self.errorView.hidden = false
            self.tableView.hidden = true
        }.addDisposableTo(disposeBag)
        
        presenter.isStartActivityIndicator.asObserver().subscribeNext { [unowned self] status in
            if status == true {
                self.activityIndicator.startAnimating()
                self.activityIndicator.hidden = false
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.hidden = true
            }
        }.addDisposableTo(disposeBag)
        
        tableViewRefreshControl.rx_controlEvent(.ValueChanged).subscribeNext { [unowned self] _ in
            self.presenter.load()
            self.tableViewRefreshControl.endRefreshing()
        }.addDisposableTo(disposeBag)
        
        tableView.rx_itemSelected.subscribeNext { [unowned self] indexPath in
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            self.router.navigateToDetailScenes(index : indexPath.row)
        }.addDisposableTo(disposeBag)
    }
}
