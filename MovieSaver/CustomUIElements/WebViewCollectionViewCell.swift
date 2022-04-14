//
//  WebViewCollectionViewCell.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 5.04.22.
//

import UIKit
import WebKit

class WebViewCollectionViewCell: UICollectionViewCell {
  private let webView = WKWebView()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.addSubview(webView)
    webView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func loadURL(_ url: URL) {
    webView.load(URLRequest(url: url))
  }
}
