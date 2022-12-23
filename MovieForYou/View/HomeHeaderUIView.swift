//
//  HomeHeaderUIView.swift
//  MovieForYou
//
//  Created by Dmitryi Velko on 22.12.2022.
//

import UIKit

class HomeHeaderUIView: UIView {
    
    // MARK: - Subviews
    private let playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonImage = UIImage(systemName: "play")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(buttonImage, for: .normal)
        button.setTitle("Play now", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(UIColor.label, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonImage = UIImage(systemName: "plus.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(buttonImage, for: .normal)
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(UIColor.label, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }()
    
    private let homeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "baner")
        return imageView
    }()

    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        homeImageView.frame = bounds
    }
    
    // MARK: - Private methods
    private func configureUI() {
        addSubview(homeImageView)
        addGradient()
        addSubview(playButton)
        addSubview(addButton)
        applyConstraints()

    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    // MARK: - SetupConstraints
    private func applyConstraints() {
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -30),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -35),
            playButton.widthAnchor.constraint(equalToConstant: 140)
        ]
        
        let addButtonConstraints = [
            addButton.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 30),
            addButton.bottomAnchor.constraint(equalTo: playButton.bottomAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 140)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(addButtonConstraints)
    }
    
    
    
}
