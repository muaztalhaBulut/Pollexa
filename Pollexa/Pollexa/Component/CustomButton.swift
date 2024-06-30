//
//  CustomButton.swift
//  Pollexa
//
//  Created by Eda Bulut on 9.06.2024.
//

import UIKit

final class CustomButton: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? UIDimensions.medium.value : UIDimensions.small.value , weight: .bold)
        label.textColor = .white
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 25 : 15, weight: .regular)
        label.textColor = .subtitleColor
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init(title: String, subtitle: String, icon: UIImage?) {
        super.init(frame: .zero)
        titleLabel.text = title
        subtitleLabel.text = subtitle
        iconImageView.image = icon
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .activeColor
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        addSubview(iconImageView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIDimensions.small.value),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: UIDimensions.tiny.value),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -UIDimensions.tiny.value),
            
            iconImageView.widthAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .pad ? UIDimensions.large.value : UIDimensions.medium.value),
            iconImageView.heightAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .pad ? UIDimensions.large.value : UIDimensions.medium.value),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIDimensions.small.value),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
