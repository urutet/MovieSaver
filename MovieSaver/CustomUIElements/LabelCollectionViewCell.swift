//
//  LabelCollectionViewCell.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 5.04.22.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
  private let label: UILabel = {
    let label = UILabel()
    
    label.font = FontsManager.bold(ofSize: 14)
    
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubview(label)
    label.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setText(_ title: String) {
    label.text = title
  }
}
