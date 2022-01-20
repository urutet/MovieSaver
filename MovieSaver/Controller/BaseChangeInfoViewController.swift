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
    let titleLabel = UILabel()
    let saveButton = UIButton()
    
    // MARK: Private
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
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Manrope-Medium", size: 24)
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.titleLabel?.font = UIFont(name: "Manrope-Medium", size: 18)
    }
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(saveButton)
    }
    
    func addConstraints() {
        titleLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(view).inset(124)
            make.leading.equalTo(view).inset(88)
            make.trailing.equalTo(view).inset(87)
        }
    }
    // MARK: - Helpers
}
