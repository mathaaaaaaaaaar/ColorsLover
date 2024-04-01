//
//  CollectionsTableViewCell.swift
//  ColorLoversApp
//
//

import UIKit

class CollectionsTableViewCell: UITableViewCell {

    @IBOutlet weak var colorLabel1: UILabel!
    @IBOutlet weak var colorLabel2: UILabel!
    @IBOutlet weak var colorLabel3: UILabel!
    @IBOutlet weak var colorLabel4: UILabel!
    @IBOutlet weak var colorLabel5: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
