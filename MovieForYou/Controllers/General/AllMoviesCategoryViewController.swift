//
//  AllMoviesCategoryViewController.swift
//  MovieForYou
//
//  Created by Dmitryi Velko on 13.01.2023.
//

import UIKit

class AllMoviesCategoryViewController: UIViewController {
    
    private var titles = [Title]()
        
    // MARK: - Subviews
    private var categoryTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(categoryTable)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        categoryTable.delegate = self
        categoryTable.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        categoryTable.frame = view.bounds
    }
    
    // MARK: - Public methods
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.categoryTable.reloadData()
        }
    }


}

// MARK: - UITableViewDelegate
extension AllMoviesCategoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        guard let titleName = title.originalTitle ?? title.originalName else { return }
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName,
                                                              youTubeVideoTrailer: videoElement,
                                                             overview: title.overview ?? "No overview",
                                                              rating: title.voteAverage))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension AllMoviesCategoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = TitleTableViewCell.identifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        let titleName = title.originalTitle ?? title.originalName ?? ""
        let titleModel = TitleViewModel(titleName: titleName,
                                        posterURL: title.posterPath ?? "",
                                        rating: title.voteAverage)
        cell.configure(with: titleModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    
}
