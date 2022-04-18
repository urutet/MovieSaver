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
    static let buttonTitleColor = UIColor.systemBlue
    static let defaultValueText = "-"
  }
  
  @IBOutlet private weak var infoNameLabel: UILabel!
  @IBOutlet private weak var infoValueLabel: UILabel!
  @IBOutlet private weak var changeInfoButton: UIButton!
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }
  
  private func commonInit() {
    loadViewFromNib()
    changeInfoButton.setTitle(Strings.AddMovie.changeButtonTitle, for: .normal)
    changeInfoButton.setTitleColor(Constants.buttonTitleColor, for: .normal)
  }
  
  private func loadViewFromNib() {
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
