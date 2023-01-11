//
//  HomeHeaderUIView.swift
//  MovieForYou
//
//  Created by Dmitryi Velko on 22.12.2022.
//

import UIKit

protocol HomeHeaderUIViewDelegate: AnyObject {
    func homeHeaderUIViewDidTapPlay(with title: Title)
}

class HomeHeaderUIView: UIView {
    
    private var title: Title?
    
    weak var delegate: HomeHeaderUIViewDelegate?
    
    // MARK: - Subviews
    private let playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        let buttonImage = UIImage(systemName: "play")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        button.setImage(buttonImage, for: .normal)
        button.setTitle("Play now", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(UIColor.white, for: .normal)
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
        button.setTitleColor(UIColor.white, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return button
    }()
    
    private let homeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.backgroundColor = .systemGray4
        label.alpha = 0.8
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        return label
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        addSubview(homeImageView)
        addGradient()
        addSubview(playButton)
        addSubview(addButton)
        addSubview(ratingLabel)
        applyConstraints()
        
        addButton.addTarget(self, action: #selector(addTitleAction), for: .touchUpInside)
        playButton.addTarget(self, action: #selector(playTitleAction), for: .touchUpInside)
       
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        homeImageView.frame = bounds
    }
    
    // MARK: - Private methods
    @objc private func playTitleAction() {
        guard let title = title else { return }
        delegate?.homeHeaderUIViewDidTapPlay(with: title)
    }
    
    @objc private func addTitleAction() {
        guard let title = title else { return }
        DataPersistenceManager.shared.addTitle(with: title) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name("add"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    // MARK: - Public method
    public func configure(with model: TitleViewModel, title: Title) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(model.posterURL)") else { return }
        homeImageView.sd_setImage(with: url)
        self.title = title
        DispatchQueue.main.async { [weak self] in
            self?.ratingLabel.text = "⭐️ \(model.rating)"
        }
    }
    
    // MARK: - Setup constraints
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
        
        let ratingLabelConstraints = [
            ratingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            ratingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            ratingLabel.widthAnchor.constraint(equalToConstant: 90),
            ratingLabel.heightAnchor.constraint(equalToConstant: 40)
        ]

        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(addButtonConstraints)
        NSLayoutConstraint.activate(ratingLabelConstraints)
    }
    
    
    
}
