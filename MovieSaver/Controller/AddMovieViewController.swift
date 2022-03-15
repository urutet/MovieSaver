//
//  AddMovieViewController.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 8.01.22.
//

import UIKit
import SnapKit

final class AddMovieViewController: UIViewController {
  // MARK: - Properties
  // MARK: Public
  weak var delegate: MovieTransferDelegate?
  
  // MARK: Private
  private enum Constants {
    static let name = "Name"
    static let rating = "Rating"
    static let releaseDate = "Release Date"
    static let link = "YouTube Link"
    static let description = "Description"
    static let imageViewBackgroundColor = UIColor.systemGray
    static let dateFormat = "dd.MM.yyyy"
    static let userDefaultsKey = "DefaultMovie"
    static let camera = "Camera"
    static let photos = "Photos"
    static let cancel = "Cancel"
  }
  
  private var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.showsVerticalScrollIndicator = false
    
    return scrollView
  }()
  
  private let mainView = UIView()
  
  // movie fields
  var movieReleaseDate: Date = Date()
  var movieYouTubeLink: URL?
  
  // items stackViews
  private let mainStackView: UIStackView = {
    let stackView = UIStackView()
    
    stackView.axis = .vertical
    stackView.distribution = .fillEqually
    
    return stackView
  }()
  
  private let firstRowHorizontalStackView: UIStackView = {
    let stackView = UIStackView()
    
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    
    return stackView
  }()
  
  private let secondRowHorizontalStackView: UIStackView = {
    let stackView = UIStackView()
    
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    
    return stackView
  }()
  
  private let nameStackView: ChangeMovieInfoStackView = {
    let stackView = ChangeMovieInfoStackView()
    
    stackView.setNameTitle(Constants.name)
    stackView.addTarget(
      target: nil,
      #selector(changeNameButtonClicked),
      for: .touchUpInside
    )
    
    return stackView
  }()
  
  private let ratingStackView: ChangeMovieInfoStackView = {
    let stackView = ChangeMovieInfoStackView()
    
    stackView.setNameTitle(Constants.rating)
    
    stackView.addTarget(
      target: nil,
      #selector(changeRatingButtonClicked),
      for: .touchUpInside
    )
    
    return stackView
  }()
  
  private let releaseDateStackView: ChangeMovieInfoStackView = {
    let stackView = ChangeMovieInfoStackView()
    
    stackView.setNameTitle(Constants.releaseDate)
    stackView.addTarget(
      target: nil,
      #selector(changeReleaseDateButtonClicked),
      for: .touchUpInside
    )
    
    return stackView
  }()
  
  private let youTubeLinkStackView: ChangeMovieInfoStackView = {
    let stackView = ChangeMovieInfoStackView()
    
    stackView.setNameTitle(Constants.link)
    stackView.addTarget(
      target: nil,
      #selector(changeYouTubeLinkButtonClicked),
      for: .touchUpInside
    )
    
    return stackView
  }()
  
  // elements
  private let setMovieImageButton: UIButton = {
    let button = UIButton()
    
    button.addTarget(
      nil,
      action: #selector(setMovieImageButtonClicked),
      for: .touchUpInside)
    
    return button
  }()
  
  private let movieImageView: UIImageView = {
    let imageView = UIImageView()
    
    imageView.backgroundColor = Constants.imageViewBackgroundColor
    imageView.clipsToBounds = true
    imageView.layer.cornerRadius = imageView.layer.bounds.height / 2
    
    return imageView
  }()
  
  private let descriptionLabel: UILabel = {
    let label = UILabel()
    
    label.text = Constants.description
    label.textAlignment = .center
    
    return label
  }()
  
  private let descriptionTextView: UITextView = {
    let textView = UITextView()
    
    textView.isEditable = true
    textView.isSelectable = true
    
    return textView
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    addSubviews()
    addConstraints()
  }
  
  override func viewDidLayoutSubviews() {
  }
  // MARK: - API
  // MARK: - Setups
  private func setupUI() {
    // navigation
    title = "Add New"
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .save,
      target: self,
      action: #selector(saveButtonClicked)
    )
  }
  
  private func addSubviews() {
    view.addSubview(scrollView)
    scrollView.addSubview(mainView)
    mainView.addSubview(movieImageView)
    mainView.addSubview(mainStackView)
    mainStackView.addArrangedSubview(firstRowHorizontalStackView)
    mainStackView.addArrangedSubview(secondRowHorizontalStackView)
    firstRowHorizontalStackView.addArrangedSubview(nameStackView)
    firstRowHorizontalStackView.addArrangedSubview(ratingStackView)
    secondRowHorizontalStackView.addArrangedSubview(releaseDateStackView)
    secondRowHorizontalStackView.addArrangedSubview(youTubeLinkStackView)
    scrollView.addSubview(setMovieImageButton)
    mainView.addSubview(descriptionLabel)
    mainView.addSubview(descriptionTextView)
  }
  
  private func addConstraints() {
    scrollView.snp.makeConstraints { make -> Void in
      make.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
    }
    
    mainView.snp.makeConstraints { make -> Void in
      make.top.bottom.leading.trailing.equalTo(scrollView)
      make.width.equalTo(scrollView)
    }
    
    movieImageView.snp.makeConstraints { make -> Void in
      make.centerX.equalTo(mainView)
      make.top.equalTo(mainView).inset(35)
      make.height.width.equalTo(150)
    }
    
    setMovieImageButton.snp.makeConstraints { make -> Void in
      make.top.bottom.leading.trailing.equalTo(movieImageView)
    }
    
    mainStackView.snp.makeConstraints { make -> Void in
      make.top.equalTo(movieImageView.snp.bottom).inset(-32)
      make.leading.trailing.equalTo(mainView).inset(40)
      make.centerX.equalTo(mainView)
      make.height.equalTo(200)
    }
    
    descriptionLabel.snp.makeConstraints { make -> Void in
      make.top.equalTo(mainStackView.snp.bottom).inset(-36)
      make.leading.trailing.equalTo(mainView).inset(32)
      make.height.equalTo(26)
    }
    
    descriptionTextView.snp.makeConstraints { make -> Void in
      make.top.equalTo(descriptionLabel.snp.bottom).inset(-11)
      make.leading.trailing.equalTo(mainView).inset(32)
      make.bottom.equalTo(mainView)
      make.height.equalTo(200)
    }
  }
  // MARK: - Helpers
  @objc private func saveButtonClicked() {
    if let url = movieYouTubeLink {
      var movie = Movie(
        name: nameStackView.getValue(),
        rating: Double(ratingStackView.getValue()) ?? 0.0,
        releaseDate: movieReleaseDate,
        link: url,
        desc: descriptionTextView.text ?? "-",
        image: movieImageView.image ?? UIImage.add
      )
      movie.image = movieImageView.image ?? UIImage.add
      
      CustomUserDefaults.set(
        object: movie,
        key: Constants.userDefaultsKey
      )
      delegate?.transferMovie(movie)
      navigationController?.popViewController(animated: true)
    }
    
  }
  
  @objc private func setMovieImageButtonClicked() {
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let cameraAction = UIAlertAction(
      title: Constants.camera,
      style: .default,
      handler: {_ in
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .camera
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = false
        self.present(imagePickerVC, animated: true, completion: nil)
      }
    )
    let photosAction = UIAlertAction(
      title: Constants.photos,
      style: .default,
      handler: {_ in
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = .photoLibrary
        imagePickerVC.delegate = self
        imagePickerVC.allowsEditing = false
        self.present(imagePickerVC, animated: true, completion: nil)
      }
    )
    let cancelAction = UIAlertAction(
      title: Constants.cancel,
      style: .cancel
    )
    
    alert.addAction(cameraAction)
    alert.addAction(photosAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  @objc private func changeNameButtonClicked() {
    if let nameVC = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "ChangeNameViewController") as? ChangeNameViewController {
      nameVC.delegate = self
      show(nameVC, sender: self)
    }
  }
  
  @objc private func changeRatingButtonClicked() {
    if let ratingVC = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "ChangeRatingViewController") as? ChangeRatingViewController {
      ratingVC.delegate = self
      show(ratingVC, sender: self)
    }
    
  }
  
  @objc private func changeReleaseDateButtonClicked() {
    if let dateVC = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "ChangeReleaseDateViewController")
        as? ChangeReleaseDateViewController {
      dateVC.delegate = self
      show(dateVC, sender: self)
    }
  }
  
  @objc private func changeYouTubeLinkButtonClicked() {
    if let youTubeLinkVC = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "ChangeYouTubeViewController") as? ChangeYouTubeViewController {
      youTubeLinkVC.delegate = self
      show(youTubeLinkVC, sender: self)
    }
  }
  
}

extension AddMovieViewController: TextTransferDelegate, URLTransferDelegate, DateTransferDelegate {
  func transferURL(_ url: URL) {
    movieYouTubeLink = url
    youTubeLinkStackView.setValue(url.absoluteString)
  }
  
  func transferDate(_ date: Date) {
    movieReleaseDate = date
    releaseDateStackView.setValue(
      date.getDateAsString(format: Constants.dateFormat)
    )
  }
  
  func transferText(_ text: String, controller: ControllerType) {
    switch controller {
    case .changeRating:
      ratingStackView.setValue(text)
    case .changeName:
      nameStackView.setValue(text)
    }
  }
}

extension AddMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
      if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        movieImageView.image = image
        picker.dismiss(animated: true, completion: nil)
      }
    }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
}
