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
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  
  @IBOutlet weak var mainView: UIView!
  
  // movie fields
  var movieReleaseDate: Date = Date()
  var movieYouTubeLink: URL?
  
  // items stackViews
  @IBOutlet weak var mainStackView: UIStackView!
  @IBOutlet weak var firstRowHorizontalStackView: UIStackView!
  @IBOutlet weak var secondRowHorizontalStackView: UIStackView!
  @IBOutlet weak var nameStackView: ChangeMovieInfoStackView!
  @IBOutlet weak var ratingStackView: ChangeMovieInfoStackView!
  @IBOutlet weak var releaseDateStackView: ChangeMovieInfoStackView!
  @IBOutlet weak var youTubeLinkStackView: ChangeMovieInfoStackView!
  
  // elements
  @IBOutlet weak var setMovieImageButton: UIButton!
  @IBOutlet weak var movieImageView: UIImageView!
  @IBOutlet weak var descriptionTextView: UITextView!
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  override func viewDidLayoutSubviews() {
    movieImageView.layer.cornerRadius = movieImageView.layer.bounds.height / 2
    
  }
  // MARK: - API
  // MARK: - Setups
  private func setupUI() {
    // navigation
    view.backgroundColor = .white
    title = "Add New"
    descriptionTextView.layer.borderWidth = 2
    descriptionTextView.layer.borderColor = UIColor.systemGray2.cgColor
    
    setMovieImageButton.setTitle("", for: .normal)
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .save,
      target: self,
      action: #selector(saveButtonClicked)
    )
    
    setMovieImageButton.addTarget(
      self,
      action: #selector(setMovieImageButtonClicked),
      for: .touchUpInside
    )
    
    nameStackView.addTarget(
      target: self,
      #selector(changeNameButtonClicked),
      for: .touchUpInside
    )
    
    ratingStackView.addTarget(
      target: self,
      #selector(changeRatingButtonClicked),
      for: .touchUpInside
    )
    
    releaseDateStackView.addTarget(
      target: self,
      #selector(changeReleaseDateButtonClicked),
      for: .touchUpInside
    )
    
    youTubeLinkStackView.addTarget(
      target: self,
      #selector(changeYouTubeLinkButtonClicked),
      for: .touchUpInside
    )
    
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
    let nameVC = ChangeNameViewController()
    nameVC.delegate = self
    navigationController?.pushViewController(nameVC, animated: true)
  }
  
  @objc private func changeRatingButtonClicked() {
    let ratingVC = ChangeRatingViewController()
    ratingVC.delegate = self
    navigationController?.pushViewController(ratingVC, animated: true)
  }
  
  @objc private func changeReleaseDateButtonClicked() {
    let dateVC = ChangeReleaseDateViewController()
    dateVC.delegate = self
    navigationController?.pushViewController(dateVC, animated: true)
  }
  
  @objc private func changeYouTubeLinkButtonClicked() {
    let youTubeLinkVC = ChangeYouTubeViewController()
    youTubeLinkVC.delegate = self
    navigationController?.pushViewController(youTubeLinkVC, animated: true)
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
