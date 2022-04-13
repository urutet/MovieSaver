//
//  MovieDetailCollectionViewController.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 5.04.22.
//

import UIKit

class MovieDetailViewController: UIViewController {

  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private enum Constants {
    static let imageCellIdentifier = "ImageCollectionViewCell"
    static let labelCellIdentifier = "LabelCollectionViewCell"
    static let textViewCellIdentifier = "TextViewCollectionViewCell"
    static let webViewCellIdentifier = "WebViewCollectionViewCell"
    static let defaultCellIdentifier = "Default"
    static let headerIdentifier = "headerID"
    static let headerKind = "movieTitleHeaderID"
    static let dateFormat = "yyyy"
    static let defaultLink = URL(string: "https://google.com")!
    static let numberOfSections = 3
    static let numberOfItemsInFirstSection = 1
    static let numberOfItemsInSecondSection = 1
    static let numberOfItemsInThirdSection = 2
  }
  
  private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
  private var movie: Movie!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationController?.navigationBar.prefersLargeTitles = false
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.defaultCellIdentifier)
    collectionView.register(LabelCollectionViewCell.self, forCellWithReuseIdentifier: Constants.labelCellIdentifier)
    collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: Constants.imageCellIdentifier)
    collectionView.register(TextViewCollectionViewCell.self, forCellWithReuseIdentifier: Constants.textViewCellIdentifier)
    collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: Constants.headerKind, withReuseIdentifier: Constants.headerIdentifier)
    collectionView.register(WebViewCollectionViewCell.self, forCellWithReuseIdentifier: Constants.webViewCellIdentifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    view.addSubview(collectionView)
    collectionView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  // MARK: - API
  func setMovie(_ movie: Movie) {
    self.movie = movie
  }
  // MARK: - Setups
  private static func createLayout() -> UICollectionViewCompositionalLayout {
    return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
      switch sectionNumber {
      case 0:
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        return section
      case 1:
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 16
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.05))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 16
        section.contentInsets.trailing = 16
        
        section.boundarySupplementaryItems = [
          .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50)), elementKind: Constants.headerKind, alignment: .topLeading)
        ]
        
        return section
      case 2:
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 16
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(400))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 16
        section.contentInsets.trailing = 16
        
        return section
      default:
        return nil
      }
    }
  }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    guard let header = collectionView.dequeueReusableSupplementaryView(
      ofKind: kind,
      withReuseIdentifier: Constants.headerIdentifier,
      for: indexPath
    ) as? HeaderCollectionReusableView
    else { return UICollectionReusableView() }
    
    header.setTitle(movie.name)
    
    return header
  }
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    Constants.numberOfSections
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    switch section {
    case 0:
      return Constants.numberOfItemsInFirstSection
    case 1:
      return Constants.numberOfItemsInSecondSection
    case 2:
      return Constants.numberOfItemsInThirdSection
    default:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch indexPath.section {
    case 0:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: Constants.imageCellIdentifier,
        for: indexPath
      ) as? ImageCollectionViewCell
      else { return UICollectionViewCell()}
      
      cell.setImage(movie.image)
      return cell
    case 1:
      guard let cell = collectionView.dequeueReusableCell(
        withReuseIdentifier: Constants.labelCellIdentifier,
        for: indexPath
      ) as? LabelCollectionViewCell
      else { return UICollectionViewCell()}
      
      cell.setText("\(movie.rating) \(movie.releaseDate.getDateAsString(format: Constants.dateFormat))")
      return cell
      
    case 2:
      if indexPath.row == 0 {
        guard let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: Constants.textViewCellIdentifier,
          for: indexPath
        ) as? TextViewCollectionViewCell
        else { return UICollectionViewCell()}
        
        cell.setText(movie.desc)
        return cell
      } else if indexPath.row == 1 {
        guard let cell = collectionView.dequeueReusableCell(
          withReuseIdentifier: Constants.webViewCellIdentifier,
          for: indexPath
        ) as? WebViewCollectionViewCell
        else { return UICollectionViewCell()}
        
        cell.loadURL(movie.youTubeLink)
        return cell
      } else {
        return UICollectionViewCell()
      }
    default:
      return UICollectionViewCell()
    }
  }
}
