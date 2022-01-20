//
//  ChangeReleaseDateViewController.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 9.01.22.
//

import UIKit

final class ChangeReleaseDateViewController: BaseChangeInfoViewController {

    // MARK: - Properties
    // MARK: Public
    weak var delegate: DateTransferDelegate?
    // MARK: Private
    private let releaseDatePicker = UIDatePicker()
    // MARK: - Lifecycle
    // MARK: - API
    // MARK: - Setups
    override func setupUI() {
        super.setupUI()
        titleLabel.text = "Release Date"
        
        releaseDatePicker.datePickerMode = .date
        releaseDatePicker.preferredDatePickerStyle = .wheels
        
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(releaseDatePicker)
    }
    
    override func addConstraints() {
        super.addConstraints()
        
        releaseDatePicker.snp.makeConstraints { make -> Void in
            make.top.equalTo(titleLabel.snp.bottom).inset(-32)
            make.leading.trailing.equalTo(view)
            make.height.equalTo(194)
        }
        
        saveButton.snp.makeConstraints { make -> Void in
            make.top.equalTo(releaseDatePicker.snp.bottom).inset(-32)
            make.centerX.equalTo(view)
        }
    }
    // MARK: - Helpers
    @objc private func saveButtonClicked() {
        delegate?.transferDate(releaseDatePicker.date)
        navigationController?.popViewController(animated: true)
    }
}
