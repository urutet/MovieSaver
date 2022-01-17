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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        addSubviews()
        addConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Private
    private let cellView = UIView()
    private let infoView = UIView()
    private let movieImageView = UIImageView()
    private let movieTitleLabel = UILabel()
    private let movieRatingLabel = UILabel()
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //cellView
        cellView.layer.cornerRadius = 16
        
        //shadow
        cellView.layer.masksToBounds = false
        cellView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        cellView.layer.shadowRadius = 16
        cellView.layer.shadowOffset = .zero
        cellView.layer.shouldRasterize = true
        
        //movieImageView
        movieImageView.clipsToBounds = true
        movieImageView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 16.0)
    }
    // MARK: - API
    // MARK: - Setups
    private func setupCell() {
        
        var bgConfig = UIBackgroundConfiguration.listPlainCell()
        bgConfig.backgroundColor = UIColor.clear
        UITableViewCell.appearance().backgroundConfiguration = bgConfig
        
        //cellView
        cellView.backgroundColor = .white
        
        //movieImageView
        movieImageView.clipsToBounds = true
        
        //movieTitleLabel
        movieTitleLabel.font = UIFont(name: "Manrope-Medium", size: 18)
        movieTitleLabel.textColor = .black
        movieTitleLabel.lineBreakMode = .byWordWrapping
        movieTitleLabel.textAlignment = .center
        movieTitleLabel.numberOfLines = 0

        //movieRatingLabel
        movieRatingLabel.font = UIFont(name: "Manrope-Bold", size: 18)
        movieRatingLabel.textColor = .black
        movieTitleLabel.lineBreakMode = .byWordWrapping
        movieRatingLabel.textAlignment = .center
        movieRatingLabel.numberOfLines = 0

    }
    
    private func addSubviews() {
        contentView.addSubview(cellView)
        cellView.addSubview(movieImageView)
        cellView.addSubview(infoView)
        cellView.addSubview(movieTitleLabel)
        cellView.addSubview(movieRatingLabel)
    }
    
    private func addConstraints() {
        //cellView
        cellView.snp.makeConstraints { make -> Void in
            make.left.equalTo(contentView).inset(22)
            make.right.equalTo(contentView).inset(18)
            make.top.bottom.equalTo(contentView).inset(22)
        }
        
        //movieImageView
        movieImageView.snp.makeConstraints { make -> Void in
            make.left.top.bottom.equalTo(cellView)
            make.right.equalTo(cellView).inset(138)
            make.height.equalTo(212)
        }
        
        //infoView
        infoView.snp.makeConstraints { make -> Void in
            make.right.top.bottom.equalTo(cellView)
            make.left.equalTo(movieImageView.snp.right)
        }
        
        //movieTitleLabel
        movieTitleLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(infoView).inset(34)
            make.bottom.equalTo(infoView).inset(119)
            make.left.right.equalTo(infoView).inset(15)
        }
        
        //movieRatingLabel
        movieRatingLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(infoView).inset(138)
            make.bottom.equalTo(infoView).inset(50)
            make.left.equalTo(infoView).inset(31)
            make.right.equalTo(infoView).inset(28)
        }
    }
    // MARK: - Helpers
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setMovieTitle(_ title: String) {
        movieTitleLabel.text = title
    }
    
    public func setMovieRating(_ rating: String) {
        movieRatingLabel.text = rating
    }
    
    public func setMovieImage(_ image: UIImage) {
        movieImageView.image = image
    }

}
