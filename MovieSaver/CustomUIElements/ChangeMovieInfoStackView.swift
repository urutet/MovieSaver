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
  
  @IBOutlet weak var mainStackView: UIStackView!
  @IBOutlet weak var infoNameLabel: UILabel!
  @IBOutlet weak var infoValueLabel: UILabel!
  @IBOutlet weak var changeInfoButton: UIButton!
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    loadViewFromNib()
    changeInfoButton.setTitle(Constants.buttonTitle, for: .normal)
    changeInfoButton.setTitleColor(Constants.buttonTitleColor, for: .normal)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    loadViewFromNib()
    changeInfoButton.setTitle(Constants.buttonTitle, for: .normal)
    changeInfoButton.setTitleColor(Constants.buttonTitleColor, for: .normal)
  }
  
  func loadViewFromNib() {
    let type = type(of: self)
    let nib = UINib(nibName: String(describing: type), bundle: Bundle(for: type))
    for case let view as UIView in nib.instantiate(withOwner: self, options: nil) {
      addSubview(view)
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
