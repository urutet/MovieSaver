//
//  ChangeNameViewController.swift
//  MovieSaver
//
//  Created by Yushkevich Ilya on 9.01.22.
//

import UIKit

final class ChangeYouTubeViewController: BaseChangeInfoViewController {

    // MARK: - Properties
    // MARK: Public
    weak var delegate: URLTransferDelegate?
    // MARK: Private
    private let youTubeTextField = UITextField()
    private let dividerView = UIView()
    // MARK: - Lifecycle
    // MARK: - API
    // MARK: - Setups
    override func setupUI() {
        super.setupUI()
        titleLabel.text = "YouTube Link"
        youTubeTextField.placeholder = "Link"
        youTubeTextField.keyboardType = .URL
        youTubeTextField.autocorrectionType = .no
        youTubeTextField.font = UIFont(name: "Manrope", size: 17)
        dividerView.backgroundColor = UIColor(red: 0.741, green: 0.741, blue: 0.741, alpha: 1)
        
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(youTubeTextField)
        view.addSubview(dividerView)
    }
    
    override func addConstraints() {
        super.addConstraints()
        youTubeTextField.snp.makeConstraints { make -> Void in
            make.top.equalTo(titleLabel.snp.bottom).inset(-42)
            make.leading.equalTo(view).inset(25)
            make.trailing.equalTo(view).inset(24)
        }
        
        dividerView.snp.makeConstraints { make -> Void in
            make.top.equalTo(youTubeTextField.snp.bottom)
            make.leading.trailing.equalTo(youTubeTextField)
            make.height.equalTo(1)
        }
        
        saveButton.snp.makeConstraints { make -> Void in
            make.top.equalTo(youTubeTextField.snp.bottom).inset(-42)
            make.centerX.equalTo(view)
        }
    }
    // MARK: - Helpers
    @objc func saveButtonClicked() {
        if let urlStr = youTubeTextField.text {
            if let url = URL(string: urlStr) {
                delegate?.transferURL(url)
                navigationController?.popViewController(animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "Invalid URL", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }
}
