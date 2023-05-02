//
//  TableViewCell.swift
//  WisdomLeaf
//
//  Created by Zindal on 02/05/23.
//

import Foundation
import UIKit
import SDWebImage

class TblListCell: UITableViewCell {
    
    // MARK: IBOutlet
    @IBOutlet var lblName: UILabel!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblDescription: UILabel!
    @IBOutlet var checkImgView: UIImageView!

    // fill up the data in cell
    func setUpCell(data:AutherInfoViewModel, selectedData:[AutherInfoViewModel]) {
        imgView.sd_setImage(with: URL.init(string: data.downloadURL))
        lblName.text = data.author
        lblDescription.text = data.url
        checkImgView.image = selectedData.contains(where: { $0.id == data.id }) ? UIImage(named: "check") : UIImage(named: "empty")
    }
}
