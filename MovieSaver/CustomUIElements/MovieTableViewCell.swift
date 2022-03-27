//
//  MovieTableViewCell.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 8.01.22.
//

import UIKit
import SnapKit

final class MovieTableViewCell: UITableViewCell {
  
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private enum Constants {
    static let shadowOpacity: Float = 0.3
    static let shadowOffset = CGSize(width: 2, height: 2)
    static let cornerRadius = 10.0
    static let backgroundColor = UIColor.white
    static let titleLabelFontSize: CGFloat = 18
    static let movieRatingLabelFontSize: CGFloat = 18
  }
  private let cellView: UIView = {
    let cell = UIView()
    
    cell.layer.cornerRadius = Constants.cornerRadius
    cell.layer.shadowOffset = Constants.shadowOffset
    cell.layer.shadowRadius = cell.layer.cornerRadius
    cell.layer.shadowOpacity = Constants.shadowOpacity
    cell.backgroundColor = Constants.backgroundColor
    
    return cell
  }()
  
  private let infoView = UIView()
  private let movieImageView: UIImageView = {
    let imageView = UIImageView()
    
    imageView.clipsToBounds = true
    imageView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 16.0)
    
    return imageView
  }()
  
  private var movieTitleLabel: UILabel = {
    let label = UILabel()
    
    label.font = FontsManager.manropeMedium(ofSize: Constants.titleLabelFontSize)
    label.textColor = .black
    label.lineBreakMode = .byWordWrapping
    label.textAlignment = .center
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    
    return label
  }()
  
  private let movieRatingLabel: UILabel = {
    let label = UILabel()
    
    label.font = FontsManager.manropeBold(ofSize: Constants.movieRatingLabelFontSize)
    label.textColor = .black
    label.textAlignment = .center
    label.numberOfLines = 0
    
    return label
  }()
  
  // MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    var bgConfig = UIBackgroundConfiguration.listPlainCell()
    
    bgConfig.backgroundColor = UIColor.clear
    UITableViewCell.appearance().backgroundConfiguration = bgConfig
    
    addSubviews()
    addConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - API
  // MARK: - Setups
  private func addSubviews() {
    contentView.addSubview(cellView)
    cellView.addSubview(movieImageView)
    cellView.addSubview(infoView)
    cellView.addSubview(movieTitleLabel)
    cellView.addSubview(movieRatingLabel)
  }
  
  private func addConstraints() {
    // cellView
    cellView.snp.makeConstraints { make -> Void in
      make.left.equalTo(contentView).inset(22)
      make.right.equalTo(contentView).inset(18)
      make.top.bottom.equalTo(contentView).inset(22)
    }
    
    // movieImageView
    movieImageView.snp.makeConstraints { make -> Void in
      make.left.top.bottom.equalTo(cellView)
      make.right.equalTo(cellView).inset(138)
      make.height.equalTo(212)
    }
    
    // infoView
    infoView.snp.makeConstraints { make -> Void in
      make.right.top.bottom.equalTo(cellView)
      make.left.equalTo(movieImageView.snp.right)
    }
    
    // movieTitleLabel
    movieTitleLabel.snp.makeConstraints { make -> Void in
      make.top.equalTo(infoView).inset(34)
      make.bottom.equalTo(infoView).inset(119)
      make.left.right.equalTo(infoView).inset(15)
    }
    
    // movieRatingLabel
    movieRatingLabel.snp.makeConstraints { make -> Void in
      make.top.equalTo(infoView).inset(138)
      make.bottom.equalTo(infoView).inset(50)
      make.left.equalTo(infoView).inset(31)
      make.right.equalTo(infoView).inset(28)
    }
  }
  // MARK: - Helpers
  
  public func setMovieTitle(_ title: String) {
    movieTitleLabel.text = title
  }
  
  public func setMovieRating(_ rating: NSMutableAttributedString) {
    movieRatingLabel.attributedText = rating
  }
  
  public func setMovieImage(_ image: UIImage) {
    movieImageView.image = image
  }
}
