//
//  Basic.swift
//  Pollexa
//
//  Created by Eda Bulut on 9.06.2024.
//

import UIKit

class Basics {
    static func makeContainerView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = UIDimensions.small.value
        view.backgroundColor = .cellColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func makeOptionsCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsSelection = true
        collectionView.isUserInteractionEnabled = true
        collectionView.register(PollOptionCollectionViewCell.self, forCellWithReuseIdentifier: "OptionCell")
        return collectionView
    }
    
    static func makeUserImage() -> UIImageView {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = UIDimensions.tiny.value * 2
        image.clipsToBounds = true
        return image
    }
    
    static func makeUserNameLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        return label
    }
    
    static func makeTimeLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }
    
    static func makeSeperator() -> UIView {
        let view = UIView()
        view.backgroundColor = .seperatorColor
        return view
    }
    
    static func makeLastVoteLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }
    
    static func makeQuestionLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }
    
    static func makeTotalVoteLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }
    
    static func makeUserStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [makeUserImage(), makeUserNameLabel(), makeTimeLabel()])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    static func makeHeaderStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [makeUserStackView(), makeSeperator(), makeLastVoteLabel(), makeQuestionLabel()])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    static func makeFooterStackView() -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: [makeOptionsCollectionView(), makeTotalVoteLabel()])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
}
