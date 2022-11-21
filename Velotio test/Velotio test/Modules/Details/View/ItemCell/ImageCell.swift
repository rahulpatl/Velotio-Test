//
//  ImageCell.swift
//  Velotio test
//
//  Created by Rahul Patil on 21/11/22.
//

import UIKit

class ImageCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cImageView: CustomImageView!
    static let id = "ImageCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func set(data: CharacterDetails) {
        titleLabel.text = data.name
        cImageView.image = nil
        if let value = data.thumbnail?.getURL().string {
            cImageView.setImg(from: value)
        }
    }
}
