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
      assertionFailure("Feature not implemented yet")
    case .name:
      setupNameView()
    case .releaseDate:
      assertionFailure("Feature not implemented yet")
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
      assertionFailure("Feature not implemented yet")
    case .name:
      saveNameValue()
    case .releaseDate:
      assertionFailure("Feature not implemented yet")
    case .link:
      assertionFailure("Feature not implemented yet")
    default:
      assertionFailure("Feature not implemented yet")
    }
  }
  
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
}
