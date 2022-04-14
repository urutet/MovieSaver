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
    static let labelFont = FontsManager.medium(ofSize: 18)
    static let buttonFont = FontsManager.medium(ofSize: 18)
    static let buttonTitleColor: UIColor = .systemBlue
    static let dividerViewColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
    static let linkFont = FontsManager.medium(ofSize: 17)
    static let ratingArray = Array(stride(from: 0.0, to: 10.0, by: 0.1))
  }
  
  private let navigator: NavigationServiceProtocol = Navigator.instance
  
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
    
    button.setTitle(Strings.General.save, for: .normal)
    button.setTitleColor(Constants.buttonTitleColor, for: .normal)
    button.titleLabel?.font = Constants.buttonFont
    button.addTarget(
      self,
      action: #selector(saveButtonClicked),
      for: .touchUpInside
    )
    
    return button
  }()
  
  private var infoTextField: UITextField!
  private var dividerView: UIView!
  private var ratingPicker: UIPickerView!
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
    
    switch inputControllerType! {
    case .rating:
      setupRatingView()
    case .name:
      setupNameView()
    case .releaseDate:
      setupDateView()
    case .link:
      setupLinkView()
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
    switch inputControllerType! {
    case .rating:
      saveRatingValue()
    case .name:
      saveNameValue()
    case .releaseDate:
      saveDateValue()
    case .link:
      saveLinkValue()
    }
  }
  
  // setup return values
  private func saveNameValue() {
    guard
      let name = infoTextField.text,
      !name.isEmpty
    else {
      let alert = UIAlertController(
        title: Strings.General.error,
        message: Strings.BaseChangeInfo.nameErrorMessage,
        preferredStyle: .alert
      )
      
      let action = UIAlertAction(title: Strings.General.ok, style: .default, handler: nil)
      alert.addAction(action)
      present(alert, animated: true, completion: nil)
      
      return
    }
    outputHandler?(.name(name))
    navigator.pop()
  }
  
  private func saveRatingValue() {
    if let rating = selectedRating {
      outputHandler?(.rating(rating))
      navigator.pop()
    }
  }
  
  private func saveDateValue() {
    outputHandler?(.releaseDate(datePicker.date))
    navigator.pop()
  }
  
  private func saveLinkValue() {
    guard let link = infoTextField.text else { return }
    if link.isEmpty {
      let alert = UIAlertController(title: Strings.General.error, message: Strings.BaseChangeInfo.nameErrorMessage, preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: Strings.General.ok, style: .default, handler: nil))
      present(alert, animated: true, completion: nil)
    } else {
      guard let url = URL(string: link) else { return }
      outputHandler?(.link(url))
      navigator.pop()
    }
  }
  
  // setup views
  private func setupNameView() {
    titleLabel.text = Strings.BaseChangeInfo.nameTitle
    infoTextField = {
      let textField = UITextField()
      
      textField.placeholder = Strings.BaseChangeInfo.nameTextFieldPlaceholder
      
      return textField
    }()
    
    dividerView = {
      let view = UIView()
      
      view.backgroundColor = Constants.dividerViewColor
      
      return view
    }()
    
    view.addSubview(infoTextField)
    view.addSubview(dividerView)
    
    infoTextField.snp.makeConstraints { make -> Void in
      make.top.equalTo(titleLabel.snp.bottom).inset(-42)
      make.leading.equalTo(view).inset(25)
      make.trailing.equalTo(view).inset(24)
    }
    
    dividerView.snp.makeConstraints { make -> Void in
      make.top.equalTo(infoTextField.snp.bottom)
      make.leading.trailing.equalTo(infoTextField)
      make.height.equalTo(1)
    }
    
    saveButton.snp.makeConstraints { make -> Void in
      make.top.equalTo(infoTextField.snp.bottom).inset(-42)
      make.centerX.equalTo(view)
    }
  }
  
  private func setupRatingView() {
    titleLabel.text = Strings.BaseChangeInfo.ratingTitle
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
    titleLabel.text = Strings.BaseChangeInfo.dateTitle
    
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
  
  private func setupLinkView() {
    titleLabel.text = Strings.BaseChangeInfo.linkTitleLabel
    infoTextField = {
      let textField = UITextField()
      
      textField.placeholder = Strings.BaseChangeInfo.linkTextFieldPlaceholder
      textField.keyboardType = .URL
      textField.autocorrectionType = .no
      textField.font = Constants.linkFont
      
      return textField
    }()
    
    dividerView = {
      let view = UIView()
      
      view.backgroundColor = Constants.dividerViewColor
      
      return view
    }()
    
    view.addSubview(infoTextField)
    view.addSubview(dividerView)
    
    infoTextField.snp.makeConstraints { make -> Void in
      make.top.equalTo(titleLabel.snp.bottom).inset(-42)
      make.leading.equalTo(view).inset(25)
      make.trailing.equalTo(view).inset(24)
    }
    
    dividerView.snp.makeConstraints { make -> Void in
      make.top.equalTo(infoTextField.snp.bottom)
      make.leading.trailing.equalTo(infoTextField)
      make.height.equalTo(1)
    }
    
    saveButton.snp.makeConstraints { make -> Void in
      make.top.equalTo(infoTextField.snp.bottom).inset(-42)
      make.centerX.equalTo(view)
    }
  }
}

extension BaseChangeInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    Constants.ratingArray.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    String(format: "%.1f", Constants.ratingArray[row])
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    selectedRating = Constants.ratingArray[row]
  }
}
