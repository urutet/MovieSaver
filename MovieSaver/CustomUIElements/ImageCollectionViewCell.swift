//
//  ImageCollectionViewCell.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 5.04.22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    
    imageView.layer.masksToBounds = true

    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(imageView)
    imageView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setImage(_ image: UIImage) {
    imageView.image = image
  }
}
