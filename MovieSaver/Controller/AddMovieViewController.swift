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
    private let scrollView = UIScrollView()
    private let mainView = UIView()
    
    //movie fields
    var movieReleaseDate: Date = Date()
    var movieYouTubeLink: URL? = nil
    //items stackViews
    private let mainVerticalStackView = UIStackView()
    private let firstRowHorizontalStackView = UIStackView()
    private let secondRowHorizontalStackView = UIStackView()
    private let nameVerticalStackView = UIStackView()
    private let ratingVerticalStackView = UIStackView()
    private let releaseDateStackView = UIStackView()
    private let youTubeLinkStackView = UIStackView()
    
    //elements
    private let movieImageView = UIImageView()
    private let setMovieImageButton = UIButton()
    private let movieNameLabel = UILabel()
    private let setMovieNameLabel = UILabel()
    private let setMovieNameButton = UIButton()
    private let movieRatingLabel = UILabel()
    private let setMovieRatingLabel = UILabel()
    private let setMovieRatingButton = UIButton()
    private let movieReleaseDateLabel = UILabel()
    private let setMovieReleaseDateLabel = UILabel()
    private let setMovieReleaseDateButton = UIButton()
    private let movieYouTubeLinkLabel = UILabel()
    private let setMovieYouTubeLinkLabel = UILabel()
    private let setMovieYouTubeLinkButton = UIButton()
    private let descriptionLabel = UILabel()
    private let descriptionTextView = UITextView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addSubviews()
        addConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        movieImageView.layer.cornerRadius = movieImageView.layer.bounds.height / 2
        
        //setting size of the scrollView
        //scrollView.contentSize = CGSize(width: view.bounds.width, height: 1000)
    }
    // MARK: - API
    // MARK: - Setups
    private func setupUI() {
        
        descriptionTextView.isEditable = true
        descriptionTextView.isSelectable = true
        
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        //navigation
        title = "Add New"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonClicked))
        
        //stackviews
        mainVerticalStackView.axis = .vertical
        mainVerticalStackView.distribution = .fillEqually
        firstRowHorizontalStackView.axis = .horizontal
        firstRowHorizontalStackView.distribution = .fillEqually
        secondRowHorizontalStackView.axis = .horizontal
        secondRowHorizontalStackView.distribution = .fillEqually
        nameVerticalStackView.axis = .vertical
        nameVerticalStackView.distribution = .fillEqually
        ratingVerticalStackView.axis = .vertical
        ratingVerticalStackView.distribution = .fillEqually
        releaseDateStackView.axis = .vertical
        releaseDateStackView.distribution = .fillEqually
        youTubeLinkStackView.axis = .vertical
        youTubeLinkStackView.distribution = .fillEqually
        
        
        //buttons
        setMovieNameButton.setTitle("Change", for: .normal)
        setMovieRatingButton.setTitle("Change", for: .normal)
        setMovieReleaseDateButton.setTitle("Change", for: .normal)
        setMovieYouTubeLinkButton.setTitle("Change", for: .normal)
        setMovieNameButton.setTitleColor(.systemBlue, for: .normal)
        setMovieRatingButton.setTitleColor(.systemBlue, for: .normal)
        setMovieReleaseDateButton.setTitleColor(.systemBlue, for: .normal)
        setMovieYouTubeLinkButton.setTitleColor(.systemBlue, for: .normal)
        
        //movieImageView
        movieImageView.backgroundColor = .systemGray
        movieImageView.clipsToBounds = true
        
        //labels
        movieNameLabel.text = "Name"
        movieNameLabel.textAlignment = .center
        movieRatingLabel.text = "Your Rating"
        movieRatingLabel.textAlignment = .center
        movieReleaseDateLabel.text = "Release Date"
        movieReleaseDateLabel.textAlignment = .center
        movieYouTubeLinkLabel.text = "YouTube Link"
        movieYouTubeLinkLabel.textAlignment = .center
        setMovieNameLabel.text = "-"
        setMovieNameLabel.textAlignment = .center
        setMovieRatingLabel.text = "-"
        setMovieRatingLabel.textAlignment = .center
        setMovieReleaseDateLabel.text = "-"
        setMovieReleaseDateLabel.textAlignment = .center
        setMovieYouTubeLinkLabel.text = "-"
        setMovieYouTubeLinkLabel.textAlignment = .center
        descriptionLabel.text = "Description"
        descriptionLabel.textAlignment = .center
        
        //targets
        setMovieNameButton.addTarget(self, action: #selector(changeNameButtonClicked), for: .touchUpInside)
        setMovieRatingButton.addTarget(self, action: #selector(changeRatingButtonClicked), for: .touchUpInside)
        setMovieReleaseDateButton.addTarget(self, action: #selector(changeReleaseDateButtonClicked), for: .touchUpInside)
        setMovieYouTubeLinkButton.addTarget(self, action: #selector(changeYouTubeLinkButtonClicked), for: .touchUpInside)
        setMovieImageButton.addTarget(self, action: #selector(changeMovieImageButtonClicked), for: .touchUpInside)
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        mainView.addSubview(movieImageView)
        mainView.addSubview(mainVerticalStackView)
        mainVerticalStackView.addArrangedSubview(firstRowHorizontalStackView)
        mainVerticalStackView.addArrangedSubview(secondRowHorizontalStackView)
        firstRowHorizontalStackView.addArrangedSubview(nameVerticalStackView)
        firstRowHorizontalStackView.addArrangedSubview(ratingVerticalStackView)
        secondRowHorizontalStackView.addArrangedSubview(releaseDateStackView)
        secondRowHorizontalStackView.addArrangedSubview(youTubeLinkStackView)
        scrollView.addSubview(setMovieImageButton)
        nameVerticalStackView.addArrangedSubview(movieNameLabel)
        nameVerticalStackView.addArrangedSubview(setMovieNameLabel)
        nameVerticalStackView.addArrangedSubview(setMovieNameButton)
        ratingVerticalStackView.addArrangedSubview(movieRatingLabel)
        ratingVerticalStackView.addArrangedSubview(setMovieRatingLabel)
        ratingVerticalStackView.addArrangedSubview(setMovieRatingButton)
        releaseDateStackView.addArrangedSubview(movieReleaseDateLabel)
        releaseDateStackView.addArrangedSubview(setMovieReleaseDateLabel)
        releaseDateStackView.addArrangedSubview(setMovieReleaseDateButton)
        youTubeLinkStackView.addArrangedSubview(movieYouTubeLinkLabel)
        youTubeLinkStackView.addArrangedSubview(setMovieYouTubeLinkLabel)
        youTubeLinkStackView.addArrangedSubview(setMovieYouTubeLinkButton)
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
        
        mainVerticalStackView.snp.makeConstraints { make -> Void in
            make.top.equalTo(movieImageView.snp.bottom).inset(-32)
            make.leading.trailing.equalTo(mainView).inset(40)
            make.centerX.equalTo(mainView)
            make.height.equalTo(200)
        }
        
        descriptionLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(setMovieYouTubeLinkButton.snp.bottom).inset(-36)
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
//            CustomUserDefaults.set(object: Movie(name: setMovieNameLabel.text ?? "-",
//                                                 image: movieImageView.image ?? UIImage.add,
//                                                 rating: Double(setMovieRatingLabel.text ?? "0.0") ?? 0.0,
//                                                 releaseDate: movieReleaseDate,
//                                                 youTubeLink: url,
//                                                 desc: descriptionTextView.text ?? "-"), key: "DefaultMovie")
            delegate?.transferMovie(Movie(name: setMovieNameLabel.text ?? "-",
                                          image: movieImageView.image ?? UIImage.add,
                                          rating: Double(setMovieRatingLabel.text ?? "0.0") ?? 0.0,
                                          releaseDate: movieReleaseDate,
                                          youTubeLink: url,
                                          desc: descriptionTextView.text ?? "-"))
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    @objc private func changeMovieImageButtonClicked() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {_ in
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.sourceType = .camera
            imagePickerVC.delegate = self
            imagePickerVC.allowsEditing = false
            self.present(imagePickerVC, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Photos", style: .default, handler: {_ in
            let imagePickerVC = UIImagePickerController()
            imagePickerVC.sourceType = .photoLibrary
            imagePickerVC.delegate = self
            imagePickerVC.allowsEditing = false
            self.present(imagePickerVC, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in
            
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func changeNameButtonClicked() {
        if let nameVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangeNameViewController") as? ChangeNameViewController {
            nameVC.delegate = self
            show(nameVC, sender: self)
        }
    }
    
    @objc private func changeRatingButtonClicked() {
        if let ratingVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangeRatingViewController") as? ChangeRatingViewController {
            ratingVC.delegate = self
            show(ratingVC, sender: self)
        }

    }
    
    @objc private func changeReleaseDateButtonClicked() {
        if let dateVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangeReleaseDateViewController") as? ChangeReleaseDateViewController {
            dateVC.delegate = self
            show(dateVC, sender: self)
        }
    }
    
    @objc private func changeYouTubeLinkButtonClicked() {
        if let youTubeLinkVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangeYouTubeViewController") as? ChangeYouTubeViewController {
            youTubeLinkVC.delegate = self
            show(youTubeLinkVC, sender: self)
        }
    }

}

extension AddMovieViewController: TextTransferDelegate, URLTransferDelegate, DateTransferDelegate {
    func transferURL(_ url: URL) {
        movieYouTubeLink = url
        setMovieYouTubeLinkLabel.text = url.absoluteString
    }
    
    func transferDate(_ date: Date) {
        movieReleaseDate = date
        setMovieReleaseDateLabel.text = date.getDateAsString(format: "dd.MM.yyyy")
    }
    
    func transferText(_ text: String, controller: ControllerType) {
        switch controller {
        case .changeRating:
            setMovieRatingLabel.text = text
        case .changeName:
            setMovieNameLabel.text = text
        }
    }
}


extension AddMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            movieImageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
