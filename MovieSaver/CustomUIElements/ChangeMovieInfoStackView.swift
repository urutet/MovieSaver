//
//  ChangeMovieInfoStackView.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 15.03.22.
//

import UIKit

class ChangeMovieInfoStackView: UIView {
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private enum Constants {
    static let buttonTitle = "Change"
    static let buttonTitleColor = UIColor.systemBlue
    static let defaultValueText = "-"
    static let stackViewAxis = NSLayoutConstraint.Axis.vertical
    static let stackViewDistribution = UIStackView.Distribution.fillEqually
  }
  
  private let mainStackView: UIStackView = {
    let stackView = UIStackView()
    
    stackView.axis = Constants.stackViewAxis
    stackView.distribution = Constants.stackViewDistribution
    
    return stackView
  }()
  
  private let infoNameLabel: UILabel = {
    let label = UILabel()
    
    label.textAlignment = .center
    
    return label
  }()
  
  private let infoValueLabel: UILabel = {
    let label = UILabel()
    
    label.text = Constants.defaultValueText
    label.textAlignment = .center
    
    return label
  }()
  
  private let changeInfoButton: UIButton = {
    let button = UIButton()
    
    button.setTitle(Constants.buttonTitle, for: .normal)
    button.setTitleColor(Constants.buttonTitleColor, for: .normal)
    
    return button
  }()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    addSubviews()
    addConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    addSubviews()
    addConstraints()
  }
  
  // MARK: - Setups
  func addSubviews() {
    addSubview(mainStackView)
    mainStackView.addArrangedSubview(infoNameLabel)
    mainStackView.addArrangedSubview(infoValueLabel)
    mainStackView.addArrangedSubview(changeInfoButton)
  }
  
  func addConstraints() {
    mainStackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  // MARK: - API
  func setNameTitle(_ title: String) {
    infoNameLabel.text = title
  }
  
  func setValue(_ value: String) {
    infoValueLabel.text = value
  }
  
  func getValue() -> String {
    return infoValueLabel.text ?? Constants.defaultValueText
  }
  
  func addTarget(target: Any?, _ selector: Selector, for value: UIControl.Event) {
    changeInfoButton.addTarget(target, action: selector, for: value)
  }
}
