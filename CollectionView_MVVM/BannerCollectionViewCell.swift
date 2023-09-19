//
//  BannerCollectionViewCell.swift
//  CollectionView_MVVM
//
//  Created by 신희권 on 2023/09/14.
//

import Foundation
import UIKit
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    static let id = "BannerCell"
    let titleLabel = UILabel()
    let backgroundImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
    }
    
    private func setUI() {
        self.addSubview(titleLabel)
        self.addSubview(backgroundImage)
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public func config(title: String, imageUrl: String) {
        
        titleLabel.text = "Title"
        //image
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init error")
    }
}
