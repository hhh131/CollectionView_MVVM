//
//  NormalCaroselCollectionViewCell.swift
//  CollectionView_MVVM
//
//  Created by 신희권 on 2023/09/20.
//

import UIKit
import SnapKit

class NormalCaroselCollectionViewCell: UICollectionViewCell {
    static let id = "NomalCarosel"
    private let mainImage = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    func setUI() {
        addSubview(mainImage)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        
        mainImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(mainImage.snp.bottom).offset(8)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
    
    func config(imageURL: String, title: String, subTitle: String?) {
        let image = URL(string: imageURL)
        mainImage.kf.setImage(with: image)
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
