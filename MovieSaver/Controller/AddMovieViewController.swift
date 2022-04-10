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
  
  private let IO: IOService = CoreDataService.instance
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
  @IBOutlet private weak var descriptionTextView: UITextView!
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  // MARK: - API
  // MARK: - Setups
  private func setupUI() {
    // navigation
    view.backgroundColor = .white
    title = "Add New"
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
    
    nameStackView.setNameTitle(Constants.name)
    nameStackView.addTarget(
      target: self,
      #selector(changeNameButtonClicked),
      for: .touchUpInside
    )
    
    ratingStackView.setNameTitle(Constants.rating)
    ratingStackView.addTarget(
      target: self,
      #selector(changeRatingButtonClicked),
      for: .touchUpInside
    )
    
    releaseDateStackView.setNameTitle(Constants.releaseDate)
    releaseDateStackView.addTarget(
      target: self,
      #selector(changeReleaseDateButtonClicked),
      for: .touchUpInside
    )
    
    youTubeLinkStackView.setNameTitle(Constants.link)
    youTubeLinkStackView.addTarget(
      target: self,
      #selector(changeYouTubeLinkButtonClicked),
      for: .touchUpInside
    )
    
  }
  
  // MARK: - Helpers
  private func showChangeInfoViewController(controllerInputType: ChangeInfoViewControllerInputType) {
    let viewController: BaseChangeInfoViewController = BaseChangeInfoViewController()
    
    viewController.inputControllerType = controllerInputType
    viewController.outputHandler = { [weak self] in
      guard let strongSelf = self else { return }
      switch $0 {
      case .rating(let rating):
        strongSelf.ratingStackView.setValue(String(rating))
      case .name(let name):
        strongSelf.nameStackView.setValue(name)
      case .releaseDate(let date):
        strongSelf.releaseDateStackView.setValue(
          date.getDateAsString(
            format:Constants.dateFormat
          )
        )
      case .link(let link):
        strongSelf.youTubeLinkStackView.setValue(link.absoluteString)
      }
      strongSelf.navigationController?.popViewController(animated: true)
    }
    
    navigationController?.pushViewController(viewController, animated: true)
  }
  
  @objc private func saveButtonClicked() {
    guard let url = URL(string: youTubeLinkStackView.getValue()) else { return }
    var movie = Movie(
      name: nameStackView.getValue(),
      rating: Double(ratingStackView.getValue()) ?? 0.0,
      releaseDate: dateFormatter.date(from: releaseDateStackView.getValue()) ?? Date(),
      link: url,
      desc: descriptionTextView.text ?? "-",
      image: movieImageView.image ?? UIImage.add
    )
    movie.image = movieImageView.image ?? UIImage.add
    
    IO.saveMovie(movie)
    
    eventHandler?(movie)
    navigationController?.popViewController(animated: true)
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
