//
//  CharacterCollectionCell.swift
//  Velotio test
//
//  Created by Rahul Patil on 18/11/22.
//

import UIKit

class CharacterCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageView: CustomImageView!
    @IBOutlet weak var bookMarkButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    weak var delegate: CharacterCellDelegate?
    private var data: CharacterDetailsStorage?
    static let identifire = "CharacterCollectionCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .lightGray
        self.layer.cornerRadius = 8
        // Initialization code
    }

    func set(data: CharacterDetailsStorage) {
        self.data = data
        titleLabel.text = data.name
        imageView.image = nil
        bookMarkButton.setImage(.init(systemName: "star"), for: .normal)
        if data.isBookmarked {
            bookMarkButton.setImage(.init(systemName: "star.fill"), for: .normal)
        }
        if let imageData = data.imageURL {
            imageView.setImg(from: imageData)
        }
    }
    
    @IBAction func didTappedBookmark(_ sender: Any) {
        guard let model = data else {return}
        delegate?.addBookmark(model: model)
    }
    
}
