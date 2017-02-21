//
//  DetailViewController.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/12.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {
    
    var presenter : DetailPresenterProtocol!
    
    @IBOutlet weak var viewItemTitle: UILabel!
    @IBOutlet weak var viewItemId: UILabel!
    
    let disposeBag = DisposeBag()
    var itemId : String = ""
    var itemTitle  : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DetailConfigurator.sharedInstance.configure(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewItemTitle.text   = itemTitle
        viewItemId.text      = itemId
        
        setSubscribe()
        presenter.load(itemId : itemId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

private extension DetailViewController {
    
    func setSubscribe() {
    }
}
