//
//  MovieDetailViewController.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 9.01.22.
//

import UIKit
import SnapKit

final class MovieDetailViewController: UIViewController {
    // MARK: - Properties
    // MARK: Public
    // MARK: Private
    private let detailsView = UIView()
    private let movieImageView = UIImageView()
    private let movieTitleLabel = UILabel()
    private let starImageView = UIImageView()
    private let ratingLabel = UILabel()
    private let yearLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let videoWebView = UIWebView()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSubviews()
        addConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        self.detailsView.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
    }
    
    // MARK: - API
    // MARK: - Setups
    private func setupUI() {
        movieImageView.clipsToBounds = true
        detailsView.backgroundColor = .white
        starImageView.image = UIImage(named: "Star")
        movieTitleLabel.font = UIFont(name: "Manrope-Bold", size: 24)
        
        ratingLabel.font = UIFont(name: "Manrope-Bold", size: 14)

        yearLabel.font = UIFont(name: "Manrope-Regular", size: 14)
        yearLabel.textColor = UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1)
        
        descriptionLabel.font = UIFont(name: "Manrope-Regular", size: 14)
    }
    
    private func addSubviews() {
        view.addSubview(movieImageView)
        view.addSubview(detailsView)
        detailsView.addSubview(movieTitleLabel)
        detailsView.addSubview(starImageView)
        detailsView.addSubview(ratingLabel)
        detailsView.addSubview(yearLabel)
        detailsView.addSubview(descriptionLabel)
        detailsView.addSubview(videoWebView)
    }
    
    private func addConstraints() {
        movieImageView.snp.makeConstraints { make -> Void in
            make.top.leading.trailing.equalTo(view)
            make.bottom.greaterThanOrEqualTo(view).inset(300)
        }
        
        detailsView.snp.makeConstraints { make -> Void in
            make.top.equalTo(view.snp.top).inset(257)
            make.bottom.leading.trailing.equalTo(view)
        }
        
        movieTitleLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(detailsView).inset(29)
            make.leading.equalTo(detailsView).inset(19)
            make.trailing.equalTo(detailsView).inset(18)
        }

        starImageView.snp.makeConstraints { make -> Void in
            make.top.equalTo(movieTitleLabel.snp.bottom).inset(-18)
            make.leading.equalTo(detailsView).inset(19)
            make.height.width.equalTo(16)
        }

        ratingLabel.snp.makeConstraints { make -> Void in
            make.centerY.equalTo(starImageView)
            make.leading.equalTo(starImageView.snp.trailing).inset(-11)
        }

        yearLabel.snp.makeConstraints { make -> Void in
            make.centerY.equalTo(ratingLabel)
            make.leading.equalTo(ratingLabel.snp.trailing).inset(-6)
        }

        descriptionLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(ratingLabel.snp.bottom).inset(-13)
            make.leading.trailing.equalTo(detailsView).inset(19)
        }

        videoWebView.snp.makeConstraints { make -> Void in
            make.top.equalTo(descriptionLabel.snp.bottom).inset(-24)
            make.leading.trailing.equalTo(descriptionLabel)
            make.bottom.equalTo(detailsView.safeAreaLayoutGuide.snp.bottom)
        }
    }
    // MARK: - Helpers
    public func setMovieImage(_ image: UIImage) {
        movieImageView.image = image
    }
    
    public func setMovieTitle(_ title: String) {
        movieTitleLabel.text = title
    }
    
    public func setMovieRating(_ rating: NSMutableAttributedString) {
        ratingLabel.attributedText = rating
    }
    
    public func setMovieYear(_ year: String) {
        yearLabel.text = year
    }
    
    public func setMovieDescription(_ desc: String) {
        descriptionLabel.text = desc
    }
    
    public func setMovieWebView(url: URL) {
        videoWebView.loadRequest(URLRequest(url: url))
    }
}
