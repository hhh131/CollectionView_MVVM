//
//  ViewController.swift
//  CollectionView_MVVM
//
//  Created by 신희권 on 2023/09/14.
//

import UIKit

class ViewController: UIViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        setDataSource()
        setSanpShot()
    }
    
    private func setUI() {
        self.view.addSubview(collectionView)
        collectionView.backgroundColor = .red
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell else { return  UICollectionViewCell() }
            cell.config(title: "", imageUrl: "String")
            return cell
        })
    }
    
    private func setSanpShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        snapshot.appendSections([Section(id: "Banner")])
        let bannerItems = [
            Item.banner(HomeItem(title: "교촌 치킨", imageUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.seoulfn.com%2Fnews%2FarticleView.html%3Fidxno%3D472569&psig=AOvVaw2Nq-IbufHrR4U8WpNPpdaS&ust=1695140938271000&source=images&cd=vfe&opi=89978449&ved=0CA4QjRxqFwoTCLCakJ7KtIEDFQAAAAAdAAAAABAH")),
            Item.banner(HomeItem(title: "굽네 치킨", imageUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.seoulfn.com%2Fnews%2FarticleView.html%3Fidxno%3D472569&psig=AOvVaw2Nq-IbufHrR4U8WpNPpdaS&ust=1695140938271000&source=images&cd=vfe&opi=89978449&ved=0CA4QjRxqFwoTCLCakJ7KtIEDFQAAAAAdAAAAABAH")),
            Item.banner(HomeItem(title: "네네 치킨", imageUrl: "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.seoulfn.com%2Fnews%2FarticleView.html%3Fidxno%3D472569&psig=AOvVaw2Nq-IbufHrR4U8WpNPpdaS&ust=1695140938271000&source=images&cd=vfe&opi=89978449&ved=0CA4QjRxqFwoTCLCakJ7KtIEDFQAAAAAdAAAAABAH")),
        ]
        snapshot.appendItems(bannerItems, toSection: Section(id: "Banner"))
        dataSource?.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout(sectionProvider: {[weak self] selectionIndex, _ in
            return self?.createBannerSection()
        })
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        //item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group =  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        //section
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
