//
//  ComicsCell.swift
//  Velotio test
//
//  Created by Rahul Patil on 21/11/22.
//

import UIKit

class ComicsCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    static let id = "ComicsCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(data: String) {
        titleLabel.text = data
    }
    
}
