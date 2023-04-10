//
//  TitlePreviewViewController.swift
//  MovieForYou
//
//  Created by Dmitryi Velko on 27.12.2022.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {
        
    // MARK: - Subviews
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemRed
        button.setTitle("Add to favourites", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        return button
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 13
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.backgroundColor = .systemGray4
        label.alpha = 0.8
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        view.addSubview(overviewLabel)
        view.addSubview(ratingLabel)
        
        configureConstraints()
        
    }
    
    // MARK: - Methods
    
    func configure(with model: TitlePreviewViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.overview
        ratingLabel.text = "⭐️ " + String(format: "%.1f", model.rating)
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youTubeVideoTrailer.id.videoId)") else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    // MARK: - Setup constraints
    
    private func configureConstraints() {
        let webViewConstraints = [
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 250)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -20)
        ]
        
        let addButtonConstraints = [
            addButton.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            addButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            addButton.widthAnchor.constraint(equalToConstant: 150)
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 25),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)        ]
        
        let ratingLabelConstraints = [
            ratingLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ratingLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            ratingLabel.widthAnchor.constraint(equalToConstant: 90),
            ratingLabel.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(addButtonConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(ratingLabelConstraints)
        
    }
    
}
