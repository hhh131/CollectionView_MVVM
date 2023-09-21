//
//  ViewController.swift
//  CollectionView_MVVM
//
//  Created by 신희권 on 2023/09/14.
//

import UIKit

class ViewController: UIViewController {
    let imageUrl = "https://www.seoulfn.com/news/photo/202211/472569_237487_3544.gif"
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.id)
        collectionView.register(NormalCaroselCollectionViewCell.self, forCellWithReuseIdentifier: NormalCaroselCollectionViewCell.id)
        collectionView.register(ListCarouselCollectionViewCell.self, forCellWithReuseIdentifier: ListCarouselCollectionViewCell.id)
        collectionView.setCollectionViewLayout(createLayout(), animated: true)
        setDataSource()
        setSanpShot()
    }
    
    private func setUI() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            switch itemIdentifier {
            case .banner(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.id, for: indexPath) as? BannerCollectionViewCell else { return  UICollectionViewCell() }
                cell.config(title: item.title, imageUrl: item.imageUrl)
                return cell
                
            case .normalCarousel(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NormalCaroselCollectionViewCell.id, for: indexPath) as? NormalCaroselCollectionViewCell else { return UICollectionViewCell() }
                cell.config(imageURL: item.imageUrl, title: item.title, subTitle: item.subTitle)
                return cell
                
            case .listCarousel(let item):
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCarouselCollectionViewCell.id, for: indexPath) as? ListCarouselCollectionViewCell else { return UICollectionViewCell() }
                cell.config(image: item.imageUrl, title: item.title, subTitle: item.subTitle)
                return cell
                
            default:
                return UICollectionViewCell()
            }
        })
    }
    
    private func setSanpShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        
        let bannerSection = Section(id: "Banner")
        snapshot.appendSections([bannerSection])
        let bannerItems = [
            Item.banner(HomeItem(title: "교촌 치킨", imageUrl: "https://www.seoulfn.com/news/photo/202211/472569_237487_3544.gif")),
            Item.banner(HomeItem(title: "굽네 치킨", imageUrl: "https://www.seoulfn.com/news/photo/202211/472569_237487_3544.gif")),
            Item.banner(HomeItem(title: "네네 치킨", imageUrl: "https://www.seoulfn.com/news/photo/202211/472569_237487_3544.gif")),
        ]
        snapshot.appendItems(bannerItems, toSection: bannerSection)
        
        let normalSection = Section(id: "NormalCarosel")
        snapshot.appendSections([normalSection])
        let normalItems = [
            Item.normalCarousel(HomeItem(title: "교촌치킨", subTitle: "간장 치킨", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "굽네치킨", subTitle: "구운 치킨", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "푸라닭 치킨", subTitle: "블랙머시기 치킨", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "네네 치킨", subTitle: "양념 치킨", imageUrl: imageUrl)),
            Item.normalCarousel(HomeItem(title: "비비큐 치킨", subTitle: "올리브 치킨", imageUrl: imageUrl)),
        ]
        snapshot.appendItems(normalItems, toSection: normalSection)
        
        let listSection = Section(id: "ListCarousel")
        snapshot.appendSections([listSection])
        let listItem = [
            Item.listCarousel(HomeItem(title: "교촌치킨", subTitle: "간장 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "굽네치킨", subTitle: "구운 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "푸라닭 치킨", subTitle: "블랙머시기 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "네네 치킨", subTitle: "양념 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "비비큐 치킨", subTitle: "올리브 치킨", imageUrl: imageUrl)),
            Item.listCarousel(HomeItem(title: "큐 치킨", subTitle: "올리브 치킨", imageUrl: imageUrl)),
        ]
        snapshot.appendItems(listItem, toSection: listSection)
        dataSource?.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 30
        return UICollectionViewCompositionalLayout(sectionProvider: {[weak self] selectionIndex, _ in
            switch selectionIndex {
            case 0:
                return self?.createBannerSection()
            case 1:
                return self?.createNormalSection()
            case 2:
                return self?.createListCarouselSection()
            default:
                return self?.createBannerSection()
            }
        },configuration: config)
    }
    
    private func createBannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
      
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group =  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
      
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
    
    private func createNormalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .absolute(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior = .continuous
        return section
    }
    
    private func createListCarouselSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 3)
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20)
        section.orthogonalScrollingBehavior =  .continuous
        return section
    }
}
