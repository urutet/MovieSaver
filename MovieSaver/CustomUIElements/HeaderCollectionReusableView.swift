//
//  HeaderCollectionReusableView.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 5.04.22.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
  private let label: UILabel = {
    let label = UILabel()
    
    label.font = FontsManager.bold(ofSize: 24)
    
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
  
  func setTitle(_ title: String) {
    label.text = title
  }
}
