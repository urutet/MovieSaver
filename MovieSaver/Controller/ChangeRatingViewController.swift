//
//  ChangeRatingViewController.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 9.01.22.
//

import UIKit
import SnapKit

final class ChangeRatingViewController: BaseChangeInfoViewController {

    // MARK: - Properties
    // MARK: Public
    weak var delegate: TextTransferDelegate?
    // MARK: Private
    private let ratingPicker = UIPickerView()
    private var selectedValue = String()
    //creating double sequence from 0.0 to 10.0
    private let rating = Array(stride(from: 0.0, to: 10.0, by: 0.1))
    // MARK: - Lifecycle
    // MARK: - API
    // MARK: - Setups
    override func setupUI() {
        super.setupUI()
        titleLabel.text = "Your Rating"
        ratingPicker.delegate = self
        ratingPicker.dataSource = self
        
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(ratingPicker)
    }
    
    override func addConstraints() {
        super.addConstraints()
        
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
    
    // MARK: - Helpers
    @objc private func saveButtonClicked() {
        delegate?.transferText(selectedValue, controller: .changeRating)
        navigationController?.popViewController(animated: true)
    }
}

extension ChangeRatingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rating.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return String(format: "%.1f", rating[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedValue = String(rating[row])
    }
    
}
