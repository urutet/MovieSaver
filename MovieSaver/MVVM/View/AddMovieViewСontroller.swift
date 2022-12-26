//
//  AddMovieViewController.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 8.01.22.
//

import UIKit

final class AddMovieViewController: UIViewController {
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private enum Constants {
    static let imageViewBackgroundColor = UIColor.systemGray
    static let dateFormat = "dd.MM.yyyy"
  }
  
  var viewModel: AddMovieViewModel!
  var eventHandler: ((Movie) -> Void)?
  
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = Constants.dateFormat
    
    return dateFormatter
  }()
  
  @IBOutlet private weak var scrollView: UIScrollView!
  @IBOutlet private weak var mainView: UIView!
  
  // items stackViews
  @IBOutlet private weak var nameStackView: ChangeMovieInfoStackView!
  @IBOutlet private weak var ratingStackView: ChangeMovieInfoStackView!
  @IBOutlet private weak var releaseDateStackView: ChangeMovieInfoStackView!
  @IBOutlet private weak var youTubeLinkStackView: ChangeMovieInfoStackView!
  
  // elements
  @IBOutlet private weak var setMovieImageButton: UIButton!
  @IBOutlet private weak var movieImageView: UIImageView!
  @IBOutlet private weak var descriptionLabel: UILabel!
  @IBOutlet private weak var descriptionTextView: UITextView!
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.bind(self) { [weak self] action in
      guard let strongSelf = self else { return }
      switch action {
      case .nameChanged(let name):
        strongSelf.nameStackView.setValue(name)
      case .ratingChanged(let rating):
        strongSelf.ratingStackView.setValue(String(rating))
      case .releaseDateChanged(let date):
        strongSelf.releaseDateStackView.setValue(date.getDateAsString(format:Constants.dateFormat))
      case .linkChanged(let link):
        strongSelf.youTubeLinkStackView.setValue(link.absoluteString)
      case .imageChanged(let image):
        strongSelf.movieImageView.image = image
      case .descriptionChanged(let desc):
        strongSelf.descriptionTextView.text = desc
      }
    }
    setupUI()
  }
  // MARK: - API
  // MARK: - Setups
  private func setupUI() {
    descriptionTextView.delegate = self
    // navigation
    view.backgroundColor = .white
    title = Strings.AddMovie.addNew
    descriptionLabel.text = Strings.AddMovie.description
    descriptionTextView.layer.borderWidth = 2
    descriptionTextView.layer.borderColor = UIColor.systemGray2.cgColor
    
    movieImageView.layer.cornerRadius = movieImageView.layer.bounds.height / 2
    
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
    
    nameStackView.setNameTitle(Strings.AddMovie.name)
    nameStackView.addTarget(
      target: self,
      #selector(changeNameButtonClicked),
      for: .touchUpInside
    )
    
    ratingStackView.setNameTitle(Strings.AddMovie.rating)
    ratingStackView.addTarget(
      target: self,
      #selector(changeRatingButtonClicked),
      for: .touchUpInside
    )
    
    releaseDateStackView.setNameTitle(Strings.AddMovie.releaseDate)
    releaseDateStackView.addTarget(
      target: self,
      #selector(changeReleaseDateButtonClicked),
      for: .touchUpInside
    )
    
    youTubeLinkStackView.setNameTitle(Strings.AddMovie.link)
    youTubeLinkStackView.addTarget(
      target: self,
      #selector(changeYouTubeLinkButtonClicked),
      for: .touchUpInside
    )
    
  }
  
  // MARK: - Helpers
  private func showChangeInfoViewController(controllerInputType: ChangeInfoViewControllerInputType) {
    viewModel.navigate(to: controllerInputType)
  }
  
  @objc private func setMovieImageButtonClicked() {
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    let cameraAction = UIAlertAction(
      title: Strings.General.camera,
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
      title: Strings.General.photos,
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
      title: Strings.General.cancel,
      style: .cancel
    )
    
    alert.addAction(cameraAction)
    alert.addAction(photosAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  @objc private func saveButtonClicked() {
    viewModel.save()
  }
  
  @objc private func changeNameButtonClicked() {
    showChangeInfoViewController(controllerInputType: .name)
  }
  
  @objc private func changeRatingButtonClicked() {
    showChangeInfoViewController(controllerInputType: .rating)
  }
  
  @objc private func changeReleaseDateButtonClicked() {
    showChangeInfoViewController(controllerInputType: .releaseDate)
  }
  
  @objc private func changeYouTubeLinkButtonClicked() {
    showChangeInfoViewController(controllerInputType: .link)
  }
}

extension AddMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
  func imagePickerController(
    _ picker: UIImagePickerController,
    didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
      if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        viewModel.image = image
        picker.dismiss(animated: true, completion: nil)
      }
    }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    picker.dismiss(animated: true, completion: nil)
  }
  
  func textViewDidChange(_ textView: UITextView) {
    viewModel.desc = textView.text
  }
}
