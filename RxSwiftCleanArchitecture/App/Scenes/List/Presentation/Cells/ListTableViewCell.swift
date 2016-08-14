//
//  ListTableViewCell.swift
//  RxSwiftCleneArchitecture
//
//  Created by kirou_16 on 2016/08/12.
//  Copyright © 2016年 kirou_16. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WebImage

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tags: UILabel!
    @IBOutlet weak var updatedAt: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var userId: UILabel!
    
    let disposeBag = DisposeBag()
    let boldFont = UIFont.boldSystemFontOfSize(17.0)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(viewModel viewModel : ListModel) {
        
        viewModel.viewIdWithTitle.drive(title.rx_text).addDisposableTo(disposeBag)
        viewModel.viewTags.drive(tags.rx_text).addDisposableTo(disposeBag)
        viewModel.viewUpdatedAt.drive(updatedAt.rx_text).addDisposableTo(disposeBag)
        viewModel.viewThumbnail.driveNext { [unowned self] thumbnail in
            self.thumbnail.sd_setImageWithURL(thumbnail)
        }.addDisposableTo(disposeBag)
        viewModel.viewBody.drive(body.rx_text).addDisposableTo(disposeBag)
        viewModel.viewUserId.drive(userId.rx_text).addDisposableTo(disposeBag)
    }
}
