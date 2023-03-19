//
//  ViewController.swift
//  UICollectionViewDataSource Example
//
//  Created by 김우성 on 2023/03/19.
//

import UIKit
import SnapKit

final class ViewController: UICollectionViewController {
    // ### 1. 데이터 모델을 정의한다
    private var catList = Cat.allCats
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    // ### 5. dataSource 인스턴스를 생성한다.
    private lazy var dataSource = makeDataSource()
    
    // ### 2. Section 를 정의한다
    enum Section {
        case main
    }
    
    // ### 3. DataSource 를 정의한다
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Cat>
    
    // ### 6. SnapShot 을 정의한다.
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Cat>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureSearchController()
        configureLayout()
        applySnapshot(animatingDifferences: false)
    }
    
    func configureCollectionView() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.reusableIdentifier)
    }
    
    // #### 4. DataSource 를 구성하는 메서드를 구현한다
    func makeDataSource() -> DataSource {
        
        // 데이터 소스는 어떤 컬렉션뷰에 적용될지와, 셀은 어떤식으로 생성할지를 포함한다
        let dataSource = DataSource(
            collectionView: collectionView,
            cellProvider: { (collectionView, indexPath, cat) -> UICollectionViewCell? in
                // 셀을 생성한다
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CollectionViewCell.reusableIdentifier,
                    for: indexPath
                ) as! CollectionViewCell
                cell.configure(cat)
                return cell
            }
            
        )
        return dataSource
    }
    
    // ### 7. SnapShot 을 생성하는 메서드를 구현한다
    func applySnapshot(animatingDifferences: Bool = true) {
        // 스냅샷을 생성한다
        var snapshot = Snapshot()
        // 스냅샷에 색션을 추가한다.
        snapshot.appendSections([.main])
        // 스냅샷에 섹션에 데이터를 추가한다.
        snapshot.appendItems(catList, toSection: .main)
        // 데이터 소스에 저장한다.
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}
// MARK: - UICollectionViewDelegate
extension ViewController {
  override func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    
    // 이제 데이터모델로 바로 접근하는 것이 아니라 데이터 모델을 통해서 데이터에 접근한다
    guard let cat = dataSource.itemIdentifier(for: indexPath) else { return }
    print(cat.name)
  }
}

// MARK: - UISearchResultsUpdating Delegate
extension ViewController: UISearchResultsUpdating {
    // 검색 시, 이곳이 호출됩니다.
    func updateSearchResults(for searchController: UISearchController) {
        catList = filteredCats(for: searchController.searchBar.text)
        applySnapshot()
    }
    
    // ### 8. 키워드를 받아서 검색하는 메서드를 구현한다.
    func filteredCats(for queryOrNil: String?) -> [Cat] {
        // 전체 데이터
        // 이 부분이 만약 서버라면, 검색 결과자체를 받아서 리턴
        let cats = Cat.allCats
        
        // 검색어가 nil 이거나 없으면, 전체를 리턴한다.
        guard let query = queryOrNil,
              !query.isEmpty else {
            return cats
        }
        
        // 전체 데이터 중에서 "name" 만 비교해서 리턴한다.
        return cats.filter { cat in
            return cat.name.lowercased().contains(query.lowercased())
        }
    }
    
    // SearchController 기본 세팅
    func configureSearchController() {
      searchController.searchResultsUpdater = self
      searchController.obscuresBackgroundDuringPresentation = false
      searchController.searchBar.placeholder = "고양이"
      navigationItem.searchController = searchController
      definesPresentationContext = true
    }
}

// MARK: - Layout Handling
extension ViewController {
  private func configureLayout() {
    collectionView.collectionViewLayout = UICollectionViewCompositionalLayout(sectionProvider: { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      let isPhone = layoutEnvironment.traitCollection.userInterfaceIdiom == UIUserInterfaceIdiom.phone
      let size = NSCollectionLayoutSize(
        widthDimension: NSCollectionLayoutDimension.fractionalWidth(1),
        heightDimension: NSCollectionLayoutDimension.absolute(isPhone ? 280 : 250)
      )
      let itemCount = isPhone ? 1 : 3
      let item = NSCollectionLayoutItem(layoutSize: size)
      let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: itemCount)
      let section = NSCollectionLayoutSection(group: group)
      section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
      section.interGroupSpacing = 10
      return section
    })
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: { context in
      self.collectionView.collectionViewLayout.invalidateLayout()
    }, completion: nil)
  }
}
