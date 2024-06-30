//
//  Basic.swift
//  Pollexa
//
//  Created by Eda Bulut on 9.06.2024.
//

import UIKit

class PollUIComponent: UIView {
     lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = UIDimensions.small.value
        view.backgroundColor = .cellColor
        return view
    }()
    
     lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = UIDimensions.tiny.value * 2
        image.clipsToBounds = true
        return image
    }()
    
     lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        return label
    }()
    
     lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
     lazy var seperator: UIView = {
        let view = UIView()
        view.backgroundColor = .seperatorColor
        return view
    }()
    
     lazy var lastVoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
     lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
     lazy var totalVoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
     lazy var optionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsSelection = true
        collectionView.isUserInteractionEnabled = true
        collectionView.register(PollOptionCollectionViewCell.self, forCellWithReuseIdentifier: "OptionCell")
        return collectionView
    }()
    
     lazy var userStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userImage, userNameLabel, timeLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()
    
     lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userStackView, seperator, lastVoteLabel, questionLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
     lazy var footerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [optionsCollectionView, totalVoteLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        containerView.addSubview(userStackView)
        containerView.addSubview(headerStackView)
        containerView.addSubview(footerStackView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        userStackView.translatesAutoresizingMaskIntoConstraints = false
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        footerStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            userImage.heightAnchor.constraint(equalToConstant: UIDimensions.large.value),
            userImage.widthAnchor.constraint(equalToConstant: UIDimensions.large.value),

            userStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: UIDimensions.tiny.value),
            userStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            userStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),

            headerStackView.topAnchor.constraint(equalTo: userStackView.bottomAnchor, constant: UIDimensions.small.value),
            headerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: UIDimensions.small.value),
            headerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -UIDimensions.small.value),
            optionsCollectionView.heightAnchor.constraint(equalToConstant: 130),
            seperator.heightAnchor.constraint(equalToConstant: 0.5),

            footerStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: UIDimensions.small.value),
            footerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: UIDimensions.small.value),
            footerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -UIDimensions.small.value),
            footerStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -UIDimensions.small.value)
        ])
    }
    func updateUser(with profileImage: UIImage, name: String, initTime: String) {
        userImage.image = profileImage
        userNameLabel.text = name
        timeLabel.text = initTime
    }

}
