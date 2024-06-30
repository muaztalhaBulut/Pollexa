//
//  PollOptionCollectionViewCell.swift
//  Pollexa
//
//  Created by Eda Bulut on 8.06.2024.
//
import UIKit
import Combine

final class PollOptionCollectionViewCell: UICollectionViewCell {
    @Published var isRightCell: Bool = false
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var optionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.accessibilityIdentifier = "optionImageView"
        return imageView
    }()
    
    private lazy var voteButton: UIButton = {
        let button = UIButton()
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.setImage(UIImage(named: "vote"), for: .normal)
        button.isHidden = false
        return button
    }()
    
    private lazy var percentageLabel: UILabel = {
        let label = UILabel()
        label.font = UIDevice.current.userInterfaceIdiom == .pad ?  UIFont.systemFont(ofSize: 17, weight: .bold) : UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.accessibilityIdentifier = "PollOptionCollectionViewCell"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !isRightCell {
            containerView.roundCorners(corners: [.topRight, .bottomRight], radius: 10)
        } else {
            containerView.roundCorners(corners: [.topLeft, .bottomLeft], radius: 10)
        }
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        backgroundColor = .clear
        containerView.addSubview(optionImageView)
        containerView.addSubview(voteButton)
        containerView.addSubview(percentageLabel)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            containerView.edgesToSuperview()
            
            optionImageView.edgesToSuperview()
            voteButton.leadingToSuperview().constant = UIDimensions.small.value
            voteButton.bottomToSuperview().constant = -UIDimensions.small.value
            voteButton.height(UIDimensions.extraLarge.value)
            voteButton.width(UIDimensions.extraLarge.value)
            
            percentageLabel.trailingToSuperview().constant = -UIDimensions.large.value
            percentageLabel.bottomToSuperview().constant = -UIDimensions.large.value
        } else {
            containerView.edgesToSuperview()
            
            optionImageView.edgesToSuperview()
            voteButton.leadingToSuperview().constant = UIDimensions.tiny.value + 2
            voteButton.bottomToSuperview().constant = -UIDimensions.tiny.value + 2
            voteButton.height(UIDimensions.large.value - 2)
            voteButton.width(UIDimensions.large.value - 2)
            
            percentageLabel.trailingToSuperview().constant = -UIDimensions.tiny.value + 2
            percentageLabel.bottomToSuperview().constant = -UIDimensions.tiny.value + 2
        }
    }
    
    func configure(with option: Option, poll: Poll, totalVotes: Int) {
        optionImageView.image = option.image
        self.percentageLabel.textColor = option.selectedVote ? .activeColor : .white
        self.percentageLabel.font = option.selectedVote ? .systemFont(ofSize: 14, weight: .heavy) : .systemFont(ofSize: 14, weight: .bold)
        
        if !poll.didVote {
            voteButton.isHidden = false
            percentageLabel.isHidden = true
        } else {
            self.isUserInteractionEnabled = false
            voteButton.isHidden = true
            percentageLabel.isHidden = false
            let percentage = (Double(option.votes) / Double(totalVotes)) * 100
            percentageLabel.text = String(format: "%.0f%%", percentage)
        }
    }
}

