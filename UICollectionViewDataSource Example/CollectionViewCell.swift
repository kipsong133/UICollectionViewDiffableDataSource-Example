//
//  CollectionViewCell.swift
//  UICollectionViewDataSource Example
//
//  Created by 김우성 on 2023/03/19.
//

import UIKit
import SnapKit
import SDWebImage

final class CollectionViewCell: UICollectionViewCell {
    static let reusableIdentifier = "CollectionViewCell"
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(_ cellData: Cat) {
        self.addSubview(cellLabel)
        cellLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).inset(10)
        }
        
        self.addSubview(cellImageView)
        cellImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.left.equalTo(self.snp.left).offset(10)
            make.right.equalTo(self.snp.right).inset(10)
            make.bottom.equalTo(cellLabel.snp.top).offset(0)
        }
        
        
        if let imageURLStr = cellData.thumbnilStr {
            cellImageView.sd_setImage(with: URL(string: imageURLStr)!)
        }
        
        cellLabel.text = cellData.name
    }
}
