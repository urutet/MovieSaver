//
//  TextViewCollectionViewCell.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 5.04.22.
//

import UIKit

class TextViewCollectionViewCell: UICollectionViewCell {
  private let textView: UITextView = {
    let textView = UITextView()
    
    textView.font = FontsManager.regular(ofSize: 14)
    textView.isSelectable = false
    textView.isEditable = false
    
    return textView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(textView)
    textView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setText(_ text: String) {
    textView.text = text
  }
}
