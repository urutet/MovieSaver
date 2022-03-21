//
//  BaseChangeInfoViewController.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 9.01.22.
//

import UIKit
import SnapKit

class BaseChangeInfoViewController: UIViewController {
  
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private enum Constants {
    static let labelFont = UIFont(name: "Manrope-Medium", size: 24)
    static let buttonTitle = "Save"
    static let buttonFont = UIFont(name: "Manrope-Medium", size: 18)
    static let buttonTitleColor: UIColor = .systemBlue
    static let dividerViewColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
    static let alertTitle = "Error"
    static let nameErrorMessage = "Fill name field"
    static let alertActionTitle = "OK"
    static let nameTitleLabel = "Movie Name"
    static let ratingTitleLabel = "Your Rating"
    static let dateTitleLabel = "Release Date"
    static let nameTextFieldPlaceholder = "Name"
  }
  
  var inputControllerType: ChangeInfoViewControllerInputType!
  var outputHandler: ((ChangeInfoViewControllerOutputType) -> Void)?
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    
    label.textAlignment = .center
    label.font = Constants.labelFont
    
    return label
  }()
  
  private let saveButton: UIButton = {
    let button = UIButton()
    
    button.setTitle("Save", for: .normal)
    button.setTitleColor(Constants.buttonTitleColor, for: .normal)
    button.titleLabel?.font = Constants.buttonFont
    button.addTarget(
      self,
      action: #selector(saveButtonClicked),
      for: .touchUpInside
    )
    
    return button
  }()
  
  private var nameTextField: UITextField!
  private var dividerView: UIView!
  private var ratingPicker: UIPickerView!
  private let ratingArray = Array(stride(from: 0.0, to: 10.0, by: 0.1))
  private var selectedRating: Double?
  private var datePicker: UIDatePicker!
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    addSubviews()
    addConstraints()
  }
  // MARK: - API
  // MARK: - Setups
  func setupUI() {
    view.backgroundColor = .white
  }
  
  func addSubviews() {
    view.addSubview(titleLabel)
    view.addSubview(saveButton)
    
    switch inputControllerType {
    case .rating:
      setupRatingView()
    case .name:
      setupNameView()
    case .releaseDate:
      setupDateView()
    case .link:
      assertionFailure("Feature not implemented yet")
    default:
      assertionFailure("Feature not implemented yet")
    }
  }
  
  func addConstraints() {
    titleLabel.snp.makeConstraints { make -> Void in
      make.top.equalTo(view).inset(124)
      make.leading.equalTo(view).inset(88)
      make.trailing.equalTo(view).inset(87)
    }
  }
  // MARK: - Helpers
  @objc
  func saveButtonClicked() {
    switch inputControllerType {
    case .rating:
      saveRatingValue()
    case .name:
      saveNameValue()
    case .releaseDate:
      saveDateValue()
    case .link:
      assertionFailure("Feature not implemented yet")
    default:
      assertionFailure("Feature not implemented yet")
    }
  }
  
  // setup return values
  private func saveNameValue() {
    if let name = nameTextField.text {
        if name.isEmpty {
          let alert = UIAlertController(title: Constants.alertTitle, message: Constants.nameErrorMessage, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: Constants.alertActionTitle, style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        } else {
          outputHandler?(.name(name))
            navigationController?.popViewController(animated: true)
        }
    }
  }
  
  private func saveRatingValue() {
    if let rating = selectedRating {
      outputHandler?(.rating(rating))
    }
    navigationController?.popViewController(animated: true)
  }
  
  private func saveDateValue() {
    outputHandler?(.releaseDate(datePicker.date))
    navigationController?.popViewController(animated: true)
  }
  
  // setup views
  private func setupNameView() {
    titleLabel.text = Constants.nameTitleLabel
    nameTextField = {
      let textField = UITextField()
      
      textField.placeholder = "Name"
      
      return textField
    }()
    
    dividerView = {
      let view = UIView()
      
      view.backgroundColor = Constants.dividerViewColor
      
      return view
    }()
    
    view.addSubview(nameTextField)
    view.addSubview(dividerView)
    
    nameTextField.snp.makeConstraints { make -> Void in
      make.top.equalTo(titleLabel.snp.bottom).inset(-42)
      make.leading.equalTo(view).inset(25)
      make.trailing.equalTo(view).inset(24)
    }
    
    dividerView.snp.makeConstraints { make -> Void in
      make.top.equalTo(nameTextField.snp.bottom)
      make.leading.trailing.equalTo(nameTextField)
      make.height.equalTo(1)
    }
    
    saveButton.snp.makeConstraints { make -> Void in
      make.top.equalTo(nameTextField.snp.bottom).inset(-42)
      make.centerX.equalTo(view)
    }
  }
  
  private func setupRatingView() {
    titleLabel.text = Constants.ratingTitleLabel
    ratingPicker = UIPickerView()
    
    view.addSubview(ratingPicker)
    
    ratingPicker.delegate = self
    ratingPicker.dataSource = self
    
    ratingPicker.snp.makeConstraints { make -> Void in
        make.top.equalTo(titleLabel.snp.bottom).inset(-32)
        make.leading.trailing.equalTo(view)
        make.height.equalTo(131)
    }

    saveButton.snp.makeConstraints { make -> Void in
        make.top.equalTo(ratingPicker.snp.bottom).inset(-32)
        make.centerX.equalTo(view)
    }
  }
  
  private func setupDateView() {
    titleLabel.text = Constants.dateTitleLabel
    
    datePicker = {
      let datePicker = UIDatePicker()
      
      datePicker.datePickerMode = .date
      datePicker.preferredDatePickerStyle = .wheels
      
      return datePicker
    }()
    
    view.addSubview(datePicker)
    
    datePicker.snp.makeConstraints { make -> Void in
        make.top.equalTo(titleLabel.snp.bottom).inset(-32)
        make.leading.trailing.equalTo(view)
        make.height.equalTo(194)
    }

    saveButton.snp.makeConstraints { make -> Void in
        make.top.equalTo(datePicker.snp.bottom).inset(-32)
        make.centerX.equalTo(view)
    }
  }
}

extension BaseChangeInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
      return ratingArray.count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return String(format: "%.1f", ratingArray[row])
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedRating = ratingArray[row]
  }
}
