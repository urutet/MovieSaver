//
//  ChangeNameViewController.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 9.01.22.
//

import UIKit

final class ChangeNameViewController: BaseChangeInfoViewController {

    // MARK: - Properties
    // MARK: Public
    weak var delegate: TextTransferDelegate?
    // MARK: Private
    private let nameTextField = UITextField()
    private let dividerView = UIView()
    // MARK: - Lifecycle
    // MARK: - API
    // MARK: - Setups
    override func setupUI() {
        super.setupUI()
        titleLabel.text = "Movie Name"
        nameTextField.placeholder = "Name"
        nameTextField.font = UIFont(name: "Manrope", size: 17)
        dividerView.backgroundColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(nameTextField)
        view.addSubview(dividerView)
    }
    
    override func addConstraints() {
        super.addConstraints()
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
    // MARK: - Helpers
    @objc func saveButtonClicked() {
        delegate?.transferText(nameTextField.text ?? "-", controller: .changeName)
        navigationController?.popViewController(animated: true)
    }
}
